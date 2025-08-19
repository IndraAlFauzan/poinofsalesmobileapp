import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/bloc/product/product_bloc.dart';
import 'package:posmobile/shared/widgets/product_card.dart';
import 'package:posmobile/shared/mixins/responsive_mixin.dart';
import 'package:posmobile/shared/config/theme_extensions.dart';

class ProductGrid extends StatelessWidget with ResponsiveMixin {
  final void Function(dynamic product) onTapProduct;

  const ProductGrid({super.key, required this.onTapProduct});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return state.when(
          initial: () => Center(
            child: CircularProgressIndicator(
              color: context.colorScheme.primary,
            ),
          ),
          loading: () => Center(
            child: CircularProgressIndicator(
              color: context.colorScheme.primary,
            ),
          ),
          failure: (msg) => Center(
            child: Text(
              msg,
              style: TextStyle(color: context.colorScheme.error),
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
                crossAxisSpacing: 6,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75, // Lebih tinggi untuk memberi ruang text
              ),
              itemBuilder: (_, i) {
                final p = products[i];
                return ProductCard(product: p, onTap: () => onTapProduct(p));
              },
            );
          },
        );
      },
    );
  }
}
