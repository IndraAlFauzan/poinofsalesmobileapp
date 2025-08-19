import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/bloc/category/category_bloc.dart';
import 'package:posmobile/bloc/flavor/flavor_bloc.dart';
import 'package:posmobile/bloc/product/product_bloc.dart';
import 'package:posmobile/bloc/spicylevel/spicy_level_bloc.dart';
import 'package:posmobile/presentations/dashboard/product/productmainpage/widgets/product_grid.dart';
import 'package:posmobile/shared/widgets/category_chips.dart';
import 'package:posmobile/shared/widgets/top_bar.dart';
import 'package:posmobile/shared/config/theme_extensions.dart';

class ProductMainPage extends StatefulWidget {
  const ProductMainPage({super.key});
  @override
  State<ProductMainPage> createState() => _ProductMainPageState();
}

class _ProductMainPageState extends State<ProductMainPage> {
  final _searchCtrl = TextEditingController();
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
                      SizedBox(height: context.spacing.md),
                      Expanded(child: ProductGridMain()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
