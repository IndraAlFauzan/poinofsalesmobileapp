import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/bloc/cart/cart_bloc.dart';
import 'package:posmobile/bloc/category/category_bloc.dart';
import 'package:posmobile/bloc/flavor/flavor_bloc.dart';
import 'package:posmobile/bloc/product/product_bloc.dart';
import 'package:posmobile/bloc/spicylevel/spicy_level_bloc.dart';
import 'package:posmobile/presentations/dashboard/transaction/addtransaction/add_transaction_page.dart';
import 'package:posmobile/shared/config/app_colors.dart';
import 'package:posmobile/shared/config/theme_extensions.dart';
import 'widgets/widgets.dart';

class TransactionCartPage extends StatefulWidget {
  const TransactionCartPage({super.key});
  @override
  State<TransactionCartPage> createState() => _TransactionCartPageState();
}

class _TransactionCartPageState extends State<TransactionCartPage> {
  final _searchCtrl = TextEditingController();
  final _cartScroll = ScrollController();
  Timer? _debounce;
  int _lastCartLen = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoryBloc>().add(const CategoryEvent.started());
      context.read<ProductBloc>().add(const ProductEvent.started());
      context.read<FlavorBloc>().add(const FlavorEvent.started());
      context.read<SpicyLevelBloc>().add(const SpicyLevelEvent.started());
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchCtrl.dispose();
    _cartScroll.dispose();
    super.dispose();
  }

  void _onSearchChanged(String q) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      final query = q.trim();

      if (query.isEmpty) {
        // Ketika search kosong, reset kategori dan filter
        context.read<CategoryBloc>().add(
          const CategoryEvent.selectCategory(0), // Reset ke "All"
        );
        // Reset filter kategori untuk menampilkan semua produk
        context.read<ProductBloc>().add(
          const ProductEvent.filterProductsByCategory(
            0,
          ), // Filter kategori "All"
        );
      } else {
        // Ketika ada search query, cari di semua produk
        context.read<ProductBloc>().add(ProductEvent.searchProducts(query));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: SafeArea(
        bottom: false,
        child: Row(
          children: [
            // LEFT: product area
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.only(bottom: context.spacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TopBar(
                      hintText: 'Cari menu...',
                      searchController: _searchCtrl,
                      onSearchChanged: _onSearchChanged,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(context.spacing.sm),
                        child: Column(
                          children: [
                            SizedBox(height: context.spacing.md),
                            CategoryChips(onChipCleared: () {}),
                            const SizedBox(height: 18),
                            Expanded(
                              child: ProductGrid(
                                onTapProduct: (p) {
                                  context.read<CartBloc>().add(
                                    CartEvent.addToCart(product: p),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // RIGHT: cart area
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: context.colorScheme.shadow.withValues(alpha: 0.1),
                      blurRadius: 16,
                      offset: const Offset(-4, 0),
                    ),
                  ],
                ),
                child: BlocConsumer<CartBloc, CartState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      updated: (items, _, __) {
                        if (items.length > _lastCartLen) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (_cartScroll.hasClients) {
                              _cartScroll.animateTo(
                                _cartScroll.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 280),
                                curve: Curves.easeOut,
                              );
                            }
                          });
                        }
                        _lastCartLen = items.length;
                      },
                      orElse: () {},
                    );
                  },
                  builder: (context, state) {
                    return state.when(
                      initial: () => const EmptyCartHint(),
                      updated: (items, totalPrice, totalQty) {
                        if (items.isEmpty) return const EmptyCartHint();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ), // Sejajar dengan padding atas yang lain
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(
                                    alpha: .05,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                height:
                                    46, // Sama dengan tinggi TopBar untuk alignment
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Rangkuman Pesanan',
                                        style: context.textTheme.titleLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.w700,
                                              color:
                                                  context.colorScheme.primary,
                                              fontSize: 16,
                                            ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: context.spacing.sm,
                                          vertical: context.spacing.xs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: context.colorScheme.primary
                                              .withValues(alpha: .07),
                                          borderRadius: BorderRadius.circular(
                                            context.radius.sm,
                                          ),
                                        ),
                                        child: Text(
                                          '#${DateTime.now().millisecondsSinceEpoch % 100000}',
                                          style: context.textTheme.labelLarge
                                              ?.copyWith(
                                                color:
                                                    context.colorScheme.primary,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Divider(height: 1, color: AppColors.divider),
                            const SizedBox(height: 14),
                            Expanded(
                              child: ListView.separated(
                                controller: _cartScroll,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 8,
                                ),
                                itemCount: items.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: 10),
                                itemBuilder: (context, i) {
                                  return ProductCartItem(
                                    item: items[i],
                                    itemIndex: i,
                                  );
                                },
                              ),
                            ),
                            TotalsBlock(
                              totalQty: totalQty,
                              totalPrice: totalPrice,
                              onPay: totalQty > 0
                                  ? () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const AddTransactionPage(),
                                      ),
                                    )
                                  : null,
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
