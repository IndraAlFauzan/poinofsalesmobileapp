import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/bloc/cart/cart_bloc.dart';
import 'package:posmobile/shared/config/app_colors.dart';
import 'package:posmobile/shared/widgets/product_cart_item.dart';

class CartItemsWidget extends StatelessWidget {
  const CartItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const SizedBox(height: 8),
        Expanded(
          child: Stack(
            children: [
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const Center(
                      child: Text("Tidak ada item dalam keranjang."),
                    ),
                    updated: (items, totalPrice, totalQty) {
                      if (items.isNotEmpty) {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3, // 2 kolom dalam grid
                                crossAxisSpacing: 8, // Jarak antar kolom
                                mainAxisSpacing: 8, // Jarak antar baris
                                childAspectRatio:
                                    0.84, // Menyesuaikan ukuran grid
                              ),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ProductCartItem(
                                item: items[index],
                                itemIndex: index,
                              ),
                            );
                          },
                        );
                      }
                      return const Center(
                        child: Text("Tidak ada item dalam keranjang."),
                      );
                    },
                  );
                },
              ),
              Positioned(
                bottom: 16, // Jarak dari bawah
                right: 16, // Jarak dari kanan
                child: FloatingActionButton.extended(
                  backgroundColor: AppColors.primary,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  label: const Text(
                    'Tambah Pesanan',
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: const Icon(Icons.add, color: Colors.white, size: 25),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
