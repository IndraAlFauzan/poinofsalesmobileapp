import 'package:flutter/material.dart';
import 'package:posmobile/data/model/response/product_model_response.dart';
import 'package:posmobile/shared/config/app_colors.dart';
import 'package:posmobile/shared/widgets/idr_format.dart';
import 'package:posmobile/shared/mixins/responsive_mixin.dart';

class ProductCard extends StatelessWidget with ResponsiveMixin {
  final Product product;
  final VoidCallback onTap;
  final bool showAddButton;
  final String? addButtonText;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    this.showAddButton = true,
    this.addButtonText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final available = product.stock > 0;

    return InkWell(
      onTap: available ? onTap : null,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
          border: Border.all(color: theme.colorScheme.outlineVariant),
        ),
        child: Column(
          children: [
            // Product image
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: _buildProductImage(theme),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: _buildAvailabilityPill(available),
                  ),
                ],
              ),
            ),
            // Product info
            Container(
              constraints: const BoxConstraints(
                minHeight: 90, // Minimal tinggi untuk info produk
              ),
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Price row - always visible
                  guaranteedPriceText(
                    idrFormat(product.price),
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                    context: context,
                  ),
                  if (showAddButton) ...[
                    const SizedBox(height: 8),
                    // Add button row
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: available ? onTap : null,
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                          backgroundColor: available
                              ? AppColors.primary
                              : AppColors.error.withValues(alpha: 0.5),
                          minimumSize: const Size(0, 32),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        icon: const Icon(Icons.add, size: 16),
                        label: Text(
                          addButtonText ?? 'Add',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(ThemeData theme) {
    if (product.photoUrl == null || product.photoUrl!.trim().isEmpty) {
      return _buildPlaceholderImage(theme);
    }

    return Image.network(
      product.photoUrl!,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => _buildPlaceholderImage(theme),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          color: theme.colorScheme.surfaceContainerHighest,
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                  : null,
              strokeWidth: 2,
              color: AppColors.primary,
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlaceholderImage(ThemeData theme) {
    return Container(
      color: theme.colorScheme.surfaceContainerHighest,
      child: Center(
        child: Icon(
          Icons.fastfood,
          size: 32,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildAvailabilityPill(bool available) {
    final bg = available
        ? AppColors.primary.withValues(alpha: 0.5)
        : AppColors.error.withValues(alpha: 0.12);
    final fg = available ? AppColors.textOnAccent : AppColors.error;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        available ? 'Tersedia' : 'Tidak Tersedia',
        style: TextStyle(color: fg, fontWeight: FontWeight.w700, fontSize: 10),
      ),
    );
  }
}
