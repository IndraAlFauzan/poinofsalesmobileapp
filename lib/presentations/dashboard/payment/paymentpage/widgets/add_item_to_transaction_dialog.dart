import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/bloc/cart/cart_bloc.dart';
import 'package:posmobile/bloc/category/category_bloc.dart';
import 'package:posmobile/bloc/pending_transaction/pending_transaction_bloc.dart';
import 'package:posmobile/bloc/product/product_bloc.dart';
import 'package:posmobile/data/model/request/edit_transaction_request.dart';
import 'package:posmobile/data/model/response/pending_transactions_response.dart';
import 'package:posmobile/shared/config/app_colors.dart';
import 'package:posmobile/shared/widgets/idr_format.dart';
import 'package:posmobile/shared/widgets/product_cart_item.dart';
import 'package:posmobile/shared/widgets/category_chips.dart';
import 'package:posmobile/presentations/dashboard/transaction/transactioncart/widgets/product_grid.dart';

class AddItemToTransactionDialog extends StatefulWidget {
  final PendingTransaction transaction;

  const AddItemToTransactionDialog({super.key, required this.transaction});

  @override
  State<AddItemToTransactionDialog> createState() =>
      _AddItemToTransactionDialogState();
}

class _AddItemToTransactionDialogState
    extends State<AddItemToTransactionDialog> {
  final ScrollController _cartScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Clear cart first for fresh start
    context.read<CartBloc>().add(const CartEvent.clearCart());
    // Load categories and products when dialog opens
    context.read<CategoryBloc>().add(const CategoryEvent.started());
    context.read<ProductBloc>().add(const ProductEvent.fetchProducts());
  }

  @override
  void dispose() {
    _cartScrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_cartScrollController.hasClients) {
        _cartScrollController.animateTo(
          _cartScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true, // Penting untuk handle keyboard
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tambah Item ke Pesanan',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${widget.transaction.orderNo} - Meja ${widget.transaction.tableNo}',
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: _buildBody()),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side - Product list with categories
          Expanded(
            flex: 2,
            child: Column(
              children: [
                CategoryChips(onChipCleared: () {}),
                const SizedBox(height: 18),
                Expanded(
                  child: ProductGrid(
                    onTapProduct: (p) {
                      context.read<CartBloc>().add(
                        CartEvent.addToCart(product: p),
                      );
                      // Auto scroll ke item baru setelah ditambahkan
                      _scrollToBottom();
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          // Right side - Cart
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Item yang Ditambahkan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(child: _buildCart()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCart() {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return state.when(
          initial: () => const Center(
            child: Text(
              'Belum ada item dipilih',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          updated: (items, totalPrice, totalQty) {
            if (items.isEmpty) {
              return const Center(
                child: Text(
                  'Belum ada item dipilih',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _cartScrollController,
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
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        idrFormat(totalPrice),
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Batal'),
          ),
          const SizedBox(width: 12),
          BlocConsumer<PendingTransactionBloc, PendingTransactionState>(
            listener: (context, state) {
              state.whenOrNull(
                transactionUpdated: (response) {
                  // Clear cart and close dialog
                  context.read<CartBloc>().add(const CartEvent.clearCart());
                  Navigator.of(context).pop();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check_circle,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Berhasil!',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const Text(
                                  'Item telah ditambahkan ke pesanan',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      backgroundColor: Colors.green[600],
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      duration: const Duration(seconds: 3),
                      action: SnackBarAction(
                        label: 'OK',
                        textColor: Colors.white,
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                      ),
                    ),
                  );
                },
                failure: (message) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: $message'),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
              );
            },
            builder: (context, transactionState) {
              final isLoading = transactionState.maybeWhen(
                loading: () => true,
                orElse: () => false,
              );

              return BlocBuilder<CartBloc, CartState>(
                builder: (context, cartState) {
                  final hasItems = cartState.maybeWhen(
                    updated: (items, _, __) => items.isNotEmpty,
                    orElse: () => false,
                  );

                  return ElevatedButton(
                    onPressed: hasItems && !isLoading ? _saveChanges : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text('Simpan'),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  void _saveChanges() {
    final cartState = context.read<CartBloc>().state;

    cartState.whenOrNull(
      updated: (cartItems, _, __) {
        if (cartItems.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Tidak ada item yang dipilih'),
              backgroundColor: Colors.orange,
            ),
          );
          return;
        }

        // Convert cart items to transaction details
        // Hanya kirim item baru saja, bukan gabungan dengan yang lama
        final newDetails = cartItems.map((cartItem) {
          return TransactionDetail(
            productId: cartItem.product.id,
            quantity: cartItem.quantity,
            note: cartItem.note,
            flavorId: cartItem.selectedFlavor?.id,
            spicyLevelId: cartItem.selectedSpicyLevel?.id,
          );
        }).toList();

        // Kirim hanya item baru yang akan ditambahkan
        final editRequest = EditTransactionRequest(details: newDetails);

        context.read<PendingTransactionBloc>().add(
          PendingTransactionEvent.editTransaction(
            transactionId: widget.transaction.transactionId,
            request: editRequest,
          ),
        );
      },
    );
  }
}
