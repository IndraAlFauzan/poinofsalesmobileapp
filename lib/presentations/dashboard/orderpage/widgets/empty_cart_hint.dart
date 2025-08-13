import 'package:flutter/material.dart';
import 'package:posmobile/shared/config/app_colors.dart';

class EmptyCartHint extends StatelessWidget {
  const EmptyCartHint({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10), // Sejajar dengan padding atas yang lain
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            height: 46, // Sama dengan tinggi TopBar untuk alignment
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rangkuman Pesanan',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.primary,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.07),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '#',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.primary,
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
                  color: theme.hintColor.withValues(alpha: 0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  'Pesanan masih kosong',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.hintColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tambakan item untuk memesan!',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.hintColor.withValues(alpha: 0.7),
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
