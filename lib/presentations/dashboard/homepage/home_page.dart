import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:posmobile/bloc/cart/cart_bloc.dart';
import 'package:posmobile/bloc/category/category_bloc.dart';
import 'package:posmobile/bloc/flavor/flavor_bloc.dart';
import 'package:posmobile/bloc/product/product_bloc.dart';
import 'package:posmobile/presentations/login/bloc/login_bloc.dart';
import 'package:posmobile/presentations/widgets/idr_format.dart';
import 'widgets/product_cart_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchCtrl = TextEditingController();
  final _cartScroll = ScrollController();
  Timer? _debounce;

  // cache length untuk auto scroll
  int _lastCartLen = 0;

  @override
  void initState() {
    super.initState();

    // === Dispatch initial events ===
    // Jika kamu masih pakai event lama: FetchCategories(), FetchProducts(), dst.
    context.read<CategoryBloc>().add(const CategoryEvent.started());
    context.read<ProductBloc>().add(const ProductEvent.started());
    context.read<FlavorBloc>().add(const FlavorEvent.started());
    // context.read<SpicyLevelBloc>().add(const SpicyLevelEvent.started());
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
        // kembalikan ke filter kategori terpilih saat ini
        // Ambil selected id dari CategoryBloc
        final catState = context.read<CategoryBloc>().state;
        int selectedId = 0; // default "Semua"
        catState.maybeWhen(
          success: (categories, selectedCategoryId) {
            selectedId = selectedCategoryId;
          },
          orElse: () {},
        );
        context.read<ProductBloc>().add(
          ProductEvent.filterProductsByCategory(selectedId),
        );
      } else {
        context.read<ProductBloc>().add(ProductEvent.searchProducts(query));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.blueGrey[50],
        body: Row(
          children: [
            // Left: Product area
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildGreeting(),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: TextField(
                        controller: _searchCtrl,
                        onChanged: _onSearchChanged,
                        decoration: InputDecoration(
                          hintText: 'Cari Produk...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    _buildCategoryChips(),
                    const SizedBox(height: 12),
                    _buildProductGrid(),
                  ],
                ),
              ),
            ),

            // Right: Cart area
            Expanded(flex: 2, child: _buildCartSection()),
          ],
        ),
      ),
    );
  }

  // ==================== WIDGETS ====================

  Widget _buildGreeting() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        // Sesuaikan dengan state login-mu (jika bukan Freezed)
        return state.maybeWhen(
          success: (loginResponse) {
            final name = loginResponse.data.user; // sesuaikan field
            return RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 20),
                children: [
                  const TextSpan(
                    text: 'Hallooo, ',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  TextSpan(
                    text: '$name!',
                    style: const TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            );
          },
          orElse: () => const Text('Memuat...', style: TextStyle(fontSize: 18)),
        );
      },
    );
  }

  Widget _buildCategoryChips() {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox(
            height: 50,
            child: Center(child: CircularProgressIndicator()),
          ),
          loading: () => const SizedBox(
            height: 50,
            child: Center(child: CircularProgressIndicator()),
          ),
          failure: (msg) =>
              SizedBox(height: 50, child: Center(child: Text(msg))),
          success: (categories, selectedId) {
            // categories: List<Category>
            return SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final c = categories[index];
                  final isSelected = c.id == selectedId;
                  return GestureDetector(
                    onTap: () {
                      context.read<CategoryBloc>().add(
                        CategoryEvent.selectCategory(c.id),
                      );
                      context.read<ProductBloc>().add(
                        ProductEvent.filterProductsByCategory(c.id),
                      );
                      // reset search box
                      if (_searchCtrl.text.isNotEmpty) {
                        _searchCtrl.clear();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue[300] : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[350]!,
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          c.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildProductGrid() {
    return Expanded(
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            failure: (msg) => Center(child: Text(msg)),
            success: (products) {
              if (products.isEmpty) {
                return const Center(child: Text('Produk tidak ditemukan.'));
              }
              return LayoutBuilder(
                builder: (context, constraints) {
                  // responsif: 2–4 kolom tergantung lebar
                  final width = constraints.maxWidth;
                  int crossAxisCount = 3;
                  if (width < 720) crossAxisCount = 2;
                  if (width > 1200) crossAxisCount = 4;

                  return GridView.builder(
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.82,
                    ),
                    itemBuilder: (context, i) {
                      final p = products[i];
                      return InkWell(
                        onTap: () {
                          context.read<CartBloc>().add(
                            CartEvent.addToCart(
                              product: p,
                              // default tanpa flavor/spicy/note
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      p.photoUrl,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      errorBuilder: (c, e, s) =>
                                          const ColoredBox(
                                            color: Colors.black12,
                                            child: Center(
                                              child: Icon(Icons.broken_image),
                                            ),
                                          ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  p.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  idrFormat(p.price),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildCartSection() {
    return Container(
      color: Colors.grey[100],
      child: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          state.maybeWhen(
            updated: (items, totalPrice, totalQty) {
              // auto scroll ke bawah saat ada item baru
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
            initial: () => const Center(child: Text("Keranjang Kosong")),
            updated: (items, totalPrice, totalQty) {
              if (items.isEmpty) {
                return const Center(child: Text("Keranjang Kosong"));
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      'Detail Pesanan',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 16,
                    ),
                    child: Dash(
                      direction: Axis.horizontal,
                      length: MediaQuery.of(context).size.width / 2.99,
                      dashColor: Colors.grey,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: _cartScroll,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(
                        bottom: 16,
                        left: 10,
                        right: 10,
                      ),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return ProductCartItem(
                          item: items[index],
                          itemIndex: index,
                        );
                      },
                    ),
                  ),
                  _buildCartTotal(totalPrice, totalQty),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildCartTotal(double totalPrice, int totalQty) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total ($totalQty item)',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  idrFormat(totalPrice),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                if (totalQty > 0) {
                  Navigator.pushNamed(context, '/transaction');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Keranjang masih kosong!")),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                'Bayar',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
