import 'package:flutter/material.dart';
import 'package:posmobile/data/model/response/product_model_response.dart';
import 'package:posmobile/shared/widgets/idr_format.dart';
import 'package:posmobile/shared/mixins/responsive_mixin.dart';
import 'package:posmobile/shared/config/theme_extensions.dart';

class ProductCard extends StatelessWidget with ResponsiveMixin {
  final Product product;
  final VoidCallback onTap;
  final bool showAddButton;
  final String? addButtonText;
  final bool compactMode;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    this.showAddButton = true,
    this.addButtonText,
    this.compactMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final available = product.stock > 0;

    return Card(
      margin: EdgeInsets.all(context.spacing.sm),
      elevation: available ? 4 : 1,
      shadowColor: context.colorScheme.shadow.withValues(alpha: 0.6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.radius.lg),
      ),
      child: InkWell(
        onTap: available ? onTap : null,
        borderRadius: BorderRadius.circular(context.radius.lg),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(context.radius.lg),
            gradient: available
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      context.colorScheme.surface,
                      context.colorScheme.surfaceContainerLow,
                    ],
                  )
                : null,
            color: available
                ? null
                : context.colorScheme.surfaceContainerLow.withValues(
                    alpha: 0.5,
                  ),
          ),
          child: Column(
            children: [
              // Product image
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(context.radius.lg),
                        ),
                        child: _buildProductImage(context),
                      ),
                    ),
                    if (!available)
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: context.colorScheme.surface.withValues(
                              alpha: 0.8,
                            ),
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(context.radius.lg),
                            ),
                          ),
                        ),
                      ),
                    Positioned(
                      top: context.spacing.sm,
                      right: context.spacing.sm,
                      child: _buildAvailabilityPill(available, context),
                    ),
                  ],
                ),
              ),
              // Product info
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(context.spacing.md),
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(context.radius.lg),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      product.name,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: context.colorScheme.onSurface,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: context.spacing.xs),
                    // Price row with enhanced styling
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.spacing.sm,
                        vertical: context.spacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: context.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(context.radius.sm),
                      ),
                      child: guaranteedPriceText(
                        idrFormat(product.price),
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: context.colorScheme.onPrimaryContainer,
                        ),
                        context: context,
                      ),
                    ),
                    if (showAddButton) ...[
                      SizedBox(height: context.spacing.md),
                      // Enhanced add button
                      Container(
                        width: double.infinity,
                        height: compactMode ? 36 : 40,
                        decoration: BoxDecoration(
                          gradient: available
                              ? LinearGradient(
                                  colors: [
                                    context.colorScheme.primary,
                                    context.colorScheme.primary.withValues(
                                      alpha: 0.8,
                                    ),
                                  ],
                                )
                              : null,
                          color: available
                              ? null
                              : context.colorScheme.errorContainer,
                          borderRadius: BorderRadius.circular(
                            context.radius.md,
                          ),
                          boxShadow: available
                              ? [
                                  BoxShadow(
                                    color: context.colorScheme.primary
                                        .withValues(alpha: 0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: available ? onTap : null,
                            borderRadius: BorderRadius.circular(
                              context.radius.md,
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: context.spacing.sm,
                                vertical: context.spacing.xs,
                              ),
                              child: compactMode
                                  ? Icon(
                                      available
                                          ? Icons.add_shopping_cart
                                          : Icons.block,
                                      size: 18,
                                      color: available
                                          ? context.colorScheme.onPrimary
                                          : context
                                                .colorScheme
                                                .onErrorContainer,
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          available
                                              ? Icons.add_shopping_cart
                                              : Icons.block,
                                          size: 16,
                                          color: available
                                              ? context.colorScheme.onPrimary
                                              : context
                                                    .colorScheme
                                                    .onErrorContainer,
                                        ),
                                        SizedBox(width: context.spacing.xs),
                                        Flexible(
                                          child: Text(
                                            available
                                                ? (addButtonText ?? 'Tambah')
                                                : 'Habis',
                                            style: context.textTheme.labelMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: available
                                                      ? context
                                                            .colorScheme
                                                            .onPrimary
                                                      : context
                                                            .colorScheme
                                                            .onErrorContainer,
                                                ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
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
      ),
    );
  }

  Widget _buildProductImage(BuildContext context) {
    if (product.photoUrl == null || product.photoUrl!.trim().isEmpty) {
      return _buildPlaceholderImage(context);
    }

    return Image.network(
      product.photoUrl!,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => _buildPlaceholderImage(context),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          color: context.colorScheme.surfaceContainerHighest,
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                  : null,
              strokeWidth: 2,
              color: context.colorScheme.primary,
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlaceholderImage(BuildContext context) {
    return Container(
      color: context.colorScheme.surfaceContainerHighest,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant_menu,
              size: 48,
              color: context.colorScheme.onSurfaceVariant.withValues(
                alpha: 0.5,
              ),
            ),
            SizedBox(height: context.spacing.xs),
            Text(
              'No Image',
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant.withValues(
                  alpha: 0.7,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailabilityPill(bool available, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing.sm,
        vertical: context.spacing.xs,
      ),
      decoration: BoxDecoration(
        color: available
            ? context.colorScheme.primary.withValues(alpha: 0.9)
            : context.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(context.radius.lg),
        boxShadow: [
          BoxShadow(
            color:
                (available
                        ? context.colorScheme.primary
                        : context.colorScheme.error)
                    .withValues(alpha: 0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            available ? Icons.check_circle : Icons.cancel,
            size: 12,
            color: available
                ? context.colorScheme.onPrimary
                : context.colorScheme.onErrorContainer,
          ),
          SizedBox(width: context.spacing.xs),
          Text(
            available ? 'Tersedia' : 'Habis',
            style: context.textTheme.labelSmall?.copyWith(
              color: available
                  ? context.colorScheme.onPrimary
                  : context.colorScheme.onErrorContainer,
              fontWeight: FontWeight.w700,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
