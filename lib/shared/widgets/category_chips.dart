import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/bloc/category/category_bloc.dart';
import 'package:posmobile/bloc/product/product_bloc.dart';
import 'package:posmobile/shared/config/app_colors.dart';
import 'package:posmobile/shared/config/theme_extensions.dart';

class CategoryChips extends StatefulWidget {
  final VoidCallback onChipCleared;

  const CategoryChips({super.key, required this.onChipCleared});

  @override
  State<CategoryChips> createState() => _CategoryChipsState();
}

class _CategoryChipsState extends State<CategoryChips> {
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        return state.when(
          initial: () => SizedBox(height: 52),
          loading: () => SizedBox(
            height: 52,
            child: Center(
              child: CircularProgressIndicator(
                color: context.colorScheme.primary,
                strokeWidth: 2,
              ),
            ),
          ),
          failure: (msg) => SizedBox(
            height: 52,
            child: Center(
              child: Text(
                msg,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.error,
                ),
              ),
            ),
          ),
          success: (categories, selectedId) {
            return SizedBox(
              height: 52, // Increased height for better touch target
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: context.spacing.sm),
                itemCount: categories.length,
                separatorBuilder: (_, __) =>
                    SizedBox(width: context.spacing.sm),
                itemBuilder: (_, i) {
                  final c = categories[i];
                  final isSelected = c.id == selectedId;
                  final isHovered = _hoveredIndex == i;

                  return MouseRegion(
                    onEnter: (_) => setState(() => _hoveredIndex = i),
                    onExit: (_) => setState(() => _hoveredIndex = null),
                    child: GestureDetector(
                      onTap: () {
                        context.read<CategoryBloc>().add(
                          CategoryEvent.selectCategory(c.id),
                        );
                        context.read<ProductBloc>().add(
                          ProductEvent.filterProductsByCategory(c.id),
                        );
                        widget.onChipCleared();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: EdgeInsets.symmetric(
                          horizontal: context.spacing.md,
                          vertical: context.spacing.sm,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? context.colorScheme.primary
                              : isHovered
                              ? context.colorScheme.primaryContainer.withValues(
                                  alpha: 0.3,
                                )
                              : context.colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(
                            context.radius.lg,
                          ),
                          border: Border.all(
                            color: isSelected
                                ? context.colorScheme.primary
                                : isHovered
                                ? context.colorScheme.primary
                                : AppColors.darkOutline,
                            width: isSelected ? 2 : 1,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: context.colorScheme.primary
                                        .withValues(alpha: 0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : isHovered
                              ? [
                                  BoxShadow(
                                    color: context.colorScheme.primary
                                        .withValues(alpha: 0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 1),
                                  ),
                                ]
                              : null,
                        ),
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (isSelected) ...[
                                Icon(
                                  Icons.check_circle,
                                  size: 16,
                                  color: context.colorScheme.onPrimary,
                                ),
                                SizedBox(width: context.spacing.xs),
                              ],
                              Text(
                                c.name,
                                style: context.textTheme.labelLarge?.copyWith(
                                  color: isSelected
                                      ? context.colorScheme.onPrimary
                                      : context.colorScheme.onSurface,
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
