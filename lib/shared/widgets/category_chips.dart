import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/bloc/category/category_bloc.dart';
import 'package:posmobile/bloc/product/product_bloc.dart';

class CategoryChips extends StatelessWidget {
  final VoidCallback onChipCleared;

  const CategoryChips({super.key, required this.onChipCleared});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox(height: 44),
          loading: () => SizedBox(
            height: 44,
            child: Center(
              child: CircularProgressIndicator(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          failure: (msg) => SizedBox(
            height: 44,
            child: Center(
              child: Text(
                msg,
                style: TextStyle(color: theme.colorScheme.error),
              ),
            ),
          ),
          success: (categories, selectedId) {
            return SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (_, i) {
                  final c = categories[i];
                  final isSelected = c.id == selectedId;
                  return GestureDetector(
                    onTap: () {
                      context.read<CategoryBloc>().add(
                        CategoryEvent.selectCategory(c.id),
                      );
                      context.read<ProductBloc>().add(
                        ProductEvent.filterProductsByCategory(c.id),
                      );
                      onChipCleared();
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? theme.colorScheme.primary
                            : theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? Colors.transparent
                              : theme.colorScheme.outlineVariant,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          c.name,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: isSelected
                                ? theme.colorScheme.onPrimary
                                : theme.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
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
