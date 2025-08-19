import 'package:flutter/material.dart';
import 'package:posmobile/shared/widgets/idr_format.dart';
import 'package:posmobile/shared/config/theme_extensions.dart';

class ProductCardWidget extends StatelessWidget {
  final String title;
  final String? imageUrl; // Changed to nullable
  final double price;
  final bool available;
  final String? category;
  final int? stock;
  final VoidCallback? onTap;

  const ProductCardWidget({
    super.key,
    required this.title,
    this.imageUrl, // Changed to optional
    required this.price,
    required this.available,
    this.category,
    this.stock,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(context.radius.xl),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.shadow.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(context.radius.xl),
        child: InkWell(
          onTap: available ? onTap : null,
          borderRadius: BorderRadius.circular(context.radius.xl),
          child: Container(
            padding: EdgeInsets.all(context.spacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image with modern styling
                Expanded(
                  flex: 6,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(context.radius.lg),
                      boxShadow: [
                        BoxShadow(
                          color: context.colorScheme.shadow.withValues(
                            alpha: 0.1,
                          ),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Main image
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              context.radius.lg,
                            ),
                            child: _buildProductImage(context),
                          ),
                        ),

                        // Gradient overlay
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                context.radius.lg,
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withValues(alpha: 0.3),
                                ],
                                stops: const [0.6, 1.0],
                              ),
                            ),
                          ),
                        ),

                        // Availability status only
                        Positioned(
                          top: context.spacing.sm,
                          right: context.spacing.sm,
                          child: _buildStatusBadge(context),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: context.spacing.md),

                // Content section
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Name
                      _buildInfoRow(
                        context,
                        'Nama',
                        title,
                        isTitle: true,
                        maxLines: 2,
                      ),

                      SizedBox(height: context.spacing.sm),

                      // Price
                      _buildInfoRow(
                        context,
                        'Harga',
                        idrFormat(price),
                        isPrimary: true,
                      ),

                      SizedBox(height: context.spacing.sm),

                      // Category and Stock row
                      Row(
                        children: [
                          if (category != null)
                            Expanded(
                              child: _buildInfoRow(
                                context,
                                'Kategori',
                                category!,
                                isCompact: true,
                              ),
                            ),

                          if (category != null && stock != null)
                            SizedBox(width: context.spacing.md),

                          if (stock != null)
                            Expanded(
                              child: _buildInfoRow(
                                context,
                                'Stok',
                                '$stock',
                                isCompact: true,
                                stockValue: stock,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage(BuildContext context) {
    if (imageUrl == null || imageUrl!.trim().isEmpty) {
      return _buildPlaceholderImage(context);
    }

    return Image.network(
      imageUrl!,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => _buildPlaceholderImage(context),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(context.radius.lg),
          ),
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                  : null,
              strokeWidth: 3,
              color: context.colorScheme.primary,
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlaceholderImage(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.radius.lg),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.colorScheme.primaryContainer.withValues(alpha: 0.1),
            context.colorScheme.secondaryContainer.withValues(alpha: 0.1),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(context.spacing.lg),
              decoration: BoxDecoration(
                color: context.colorScheme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.restaurant_menu,
                size: 32,
                color: context.colorScheme.primary.withValues(alpha: 0.7),
              ),
            ),
            SizedBox(height: context.spacing.sm),
            Text(
              'No Image',
              style: context.textTheme.labelMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant.withValues(
                  alpha: 0.6,
                ),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacing.sm,
        vertical: context.spacing.xs,
      ),
      decoration: BoxDecoration(
        color: available
            ? context.colorScheme.primary
            : context.colorScheme.error,
        borderRadius: BorderRadius.circular(context.radius.lg),
        boxShadow: [
          BoxShadow(
            color:
                (available
                        ? context.colorScheme.primary
                        : context.colorScheme.error)
                    .withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            available ? Icons.check_circle : Icons.cancel,
            size: 14,
            color: Colors.white,
          ),
          SizedBox(width: context.spacing.xs),
          Text(
            available ? 'Available' : 'Sold Out',
            style: context.textTheme.labelSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value, {
    bool isTitle = false,
    bool isPrimary = false,
    bool isCompact = false,
    int maxLines = 1,
    int? stockValue,
  }) {
    // Determine colors based on stock for stock info
    Color? valueColor;
    if (stockValue != null) {
      if (stockValue == 0) {
        valueColor = context.colorScheme.error;
      } else if (stockValue <= 10) {
        valueColor = Colors.orange;
      } else {
        valueColor = Colors.green;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label
        Text(
          '$label:',
          style: context.textTheme.labelMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
            fontSize: isCompact ? 11 : 12,
          ),
        ),
        SizedBox(height: context.spacing.xs),

        // Value
        if (isPrimary)
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.spacing.sm,
              vertical: context.spacing.xs,
            ),
            decoration: BoxDecoration(
              color: available
                  ? context.colorScheme.primaryContainer
                  : context.colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(context.radius.sm),
            ),
            child: Text(
              value,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: isCompact ? 14 : 16,
                color: available
                    ? context.colorScheme.onPrimaryContainer
                    : context.colorScheme.onErrorContainer,
              ),
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
            ),
          )
        else
          Text(
            value,
            style: isTitle
                ? context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: context.colorScheme.onSurface,
                    height: 1.1,
                  )
                : context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: valueColor ?? context.colorScheme.onSurface,
                    fontSize: isCompact ? 18 : 20,
                  ),
            maxLines: maxLines,

            overflow: TextOverflow.ellipsis,
          ),
      ],
    );
  }
}
