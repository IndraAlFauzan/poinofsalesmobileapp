import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/bloc/product/product_bloc.dart';
import 'product_card.dart';

class ProductGrid extends StatelessWidget {
  final void Function(dynamic product) onTapProduct;

  const ProductGrid({super.key, required this.onTapProduct});

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
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(.6),
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
                childAspectRatio: .78,
              ),
              itemBuilder: (_, i) {
                final p = products[i];
                return ProductCard(
                  title: p.name,
                  imageUrl: p.photoUrl,
                  price: p.price,
                  available: true,
                  onTap: () => onTapProduct(p),
                );
              },
            );
          },
        );
      },
    );
  }
}
