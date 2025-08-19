import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/bloc/product/product_bloc.dart';
import 'package:posmobile/presentations/dashboard/product/productmainpage/widgets/pruduct_card_widget.dart';
import 'package:posmobile/shared/mixins/responsive_mixin.dart';
import 'package:posmobile/shared/config/theme_extensions.dart';

class ProductGridMain extends StatelessWidget with ResponsiveMixin {
  const ProductGridMain({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return state.when(
          initial: () => Center(
            child: CircularProgressIndicator(
              color: context.colorScheme.primary,
              strokeWidth: 2,
            ),
          ),
          loading: () => Center(
            child: CircularProgressIndicator(
              color: context.colorScheme.primary,
              strokeWidth: 2,
            ),
          ),
          failure: (msg) => Center(
            child: Text(
              msg,
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.error,
              ),
            ),
          ),
          success: (products) {
            if (products.isEmpty) {
              return Center(
                child: Text(
                  'No items found',
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.colorScheme.onSurface.withValues(alpha: 0.6),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }
            return GridView.builder(
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: getResponsiveGridCount(context),
                crossAxisSpacing: context.spacing.md,
                mainAxisSpacing: context.spacing.md,
                childAspectRatio: 0.65, // Lebih tinggi untuk memberi ruang text
              ),
              itemBuilder: (_, i) {
                final p = products[i];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProductCardWidget(
                    title: p.name,
                    imageUrl: p.photoUrl,
                    price: p.price,
                    available: p.stock > 0,
                    category: p.category,
                    stock: p.stock,
                    onTap: () {
                      // Handle product tap - you can implement navigation here
                      // For example: Navigator.push to product detail page
                    },
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
