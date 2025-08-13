import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/bloc/product/product_bloc.dart';
import 'package:posmobile/presentations/dashboard/product/productmainpage/widgets/pruduct_card_widget.dart';

class ProductGridMain extends StatelessWidget {
  const ProductGridMain({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return state.when(
          initial: () => Center(
            child: CircularProgressIndicator(color: theme.colorScheme.primary),
          ),
          loading: () => Center(
            child: CircularProgressIndicator(color: theme.colorScheme.primary),
          ),
          failure: (msg) => Center(
            child: Text(msg, style: TextStyle(color: theme.colorScheme.error)),
          ),
          success: (products) {
            if (products.isEmpty) {
              return Center(
                child: Text(
                  'No items found',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }
            return GridView.builder(
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 220,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (_, i) {
                final p = products[i];
                return ProductCardWidget(
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
                );
              },
            );
          },
        );
      },
    );
  }
}
