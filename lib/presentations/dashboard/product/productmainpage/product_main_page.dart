import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/bloc/cart/cart_bloc.dart';
import 'package:posmobile/bloc/category/category_bloc.dart';
import 'package:posmobile/bloc/flavor/flavor_bloc.dart';
import 'package:posmobile/bloc/product/product_bloc.dart';
import 'package:posmobile/bloc/spicylevel/spicy_level_bloc.dart';
import 'package:posmobile/presentations/dashboard/product/productmainpage/widgets/product_grid.dart';
import 'package:posmobile/shared/widgets/category_chips.dart';
import 'package:posmobile/shared/widgets/top_bar.dart';

class ProductMainPage extends StatefulWidget {
  const ProductMainPage({super.key});
  @override
  State<ProductMainPage> createState() => _ProductMainPageState();
}

class _ProductMainPageState extends State<ProductMainPage> {
  final _searchCtrl = TextEditingController();
  final _cartScroll = ScrollController();
  Timer? _debounce;

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
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        bottom: false,
        child: Row(
          children: [
            // LEFT: product area
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(
                  // left: 28,
                  // right: 28,
                  // top: 10, // Sejajar dengan logo SideMenu
                  bottom: 20,
                ),
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
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 18),
                            CategoryChips(onChipCleared: () {}),
                            const SizedBox(height: 18),
                            Expanded(child: ProductGridMain()),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Aksi ketika FAB ditekan, misalnya membuka halaman tambah produk
          // Navigator.of(context).pushNamed('/add-product');
        },
        label: const Text('Tambah Produk'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
