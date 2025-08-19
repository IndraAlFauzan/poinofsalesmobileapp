import 'package:flutter/material.dart';
import 'package:posmobile/shared/config/app_colors.dart';
import 'package:posmobile/shared/config/theme_extensions.dart';

class EmptyCartHint extends StatelessWidget {
  const EmptyCartHint({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: context.spacing.sm),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.spacing.sm),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.spacing.md,
              vertical: context.spacing.sm,
            ),
            decoration: BoxDecoration(
              color: context.colorScheme.primary.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(context.radius.sm),
            ),
            height: 46, // Sama dengan tinggi TopBar untuk alignment
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rangkuman Pesanan',
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: context.colorScheme.primary,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.spacing.sm,
                    vertical: context.spacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary.withValues(alpha: 0.07),
                    borderRadius: BorderRadius.circular(context.radius.sm),
                  ),
                  child: Text(
                    '#',
                    style: context.textTheme.labelLarge?.copyWith(
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Divider(height: 1, color: AppColors.divider),
        const SizedBox(height: 20),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 72,
                  color: context.colorScheme.onSurface.withValues(alpha: 0.3),
                ),
                SizedBox(height: context.spacing.md),
                Text(
                  'Pesanan masih kosong',
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.colorScheme.onSurface.withValues(alpha: 0.6),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: context.spacing.sm),
                Text(
                  'Tambakan item untuk memesan!',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurface.withValues(alpha: 0.4),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
