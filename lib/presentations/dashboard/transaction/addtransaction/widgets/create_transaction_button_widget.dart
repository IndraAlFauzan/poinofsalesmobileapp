import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/bloc/cart/cart_bloc.dart';
import 'package:posmobile/bloc/pending_transaction/pending_transaction_bloc.dart';
import 'package:posmobile/data/model/response/table_response.dart';
import 'package:posmobile/presentations/dashboard/transaction/addtransaction/widgets/service_type_dropdown.dart';
import 'package:posmobile/presentations/dashboard/transaction/addtransaction/widgets/table_dropdown.dart';
import 'package:posmobile/presentations/login/bloc/login_bloc.dart';
import 'package:posmobile/data/model/request/create_transaction_request.dart';
import 'package:posmobile/presentations/dashboard/transaction/addtransaction/widgets/transaction_success_dialog.dart';
import 'package:posmobile/presentations/dashboard/main_page.dart';
import 'package:posmobile/shared/config/app_colors.dart';

class CreateTransactionButtonWidget extends StatefulWidget {
  final Function(String?)? onValidationError;

  const CreateTransactionButtonWidget({super.key, this.onValidationError});

  @override
  State<CreateTransactionButtonWidget> createState() =>
      _CreateTransactionButtonWidgetState();
}

class _CreateTransactionButtonWidgetState
    extends State<CreateTransactionButtonWidget> {
  final _customerController = TextEditingController();
  final _scrollController = ScrollController();
  String? selectedServiceType;
  TableData? selectedTable;

  @override
  void dispose() {
    _customerController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onServiceTypeChanged(String? serviceType) {
    setState(() {
      selectedServiceType = serviceType;
      // Reset table selection when changing from dine_in to other service types
      if (serviceType != 'dine_in') {
        selectedTable = null;
      }
    });
  }

  void _onTableChanged(TableData? table) {
    setState(() {
      selectedTable = table;
    });
  }

  String _getServiceTypeName() {
    switch (selectedServiceType) {
      case 'dine_in':
        return 'Dine In';
      case 'take_away':
        return 'Take Away';
      case 'delivery':
        return 'Delivery';
      default:
        return 'Tidak Diketahui';
    }
  }

  void _createOrder() {
    // Validation
    if (selectedServiceType == null) {
      widget.onValidationError?.call('Pilih tipe layanan terlebih dahulu');
      return;
    }

    // Table validation only for dine in
    if (selectedServiceType == 'dine_in' && selectedTable == null) {
      widget.onValidationError?.call('Pilih meja terlebih dahulu');
      return;
    }

    if (_customerController.text.isEmpty) {
      widget.onValidationError?.call('Masukkan nama customer');
      return;
    }

    // Get user ID from login state
    final loginState = context.read<LoginBloc>().state;
    int? userId;
    loginState.whenOrNull(
      success: (response) {
        userId = response.data.userId;
      },
    );

    if (userId == null) {
      widget.onValidationError?.call('User tidak terautentikasi');
      return;
    }

    final cartState = context.read<CartBloc>().state;

    List<dynamic> cartItems = [];
    cartState.when(
      initial: () {
        widget.onValidationError?.call('Keranjang kosong');
        return;
      },
      updated: (items, totalPrice, totalQty) {
        if (items.isEmpty) {
          widget.onValidationError?.call('Keranjang kosong');
          return;
        }
        cartItems = items;
      },
    );

    if (cartItems.isEmpty) return;

    final request = CreateTransactionRequest(
      tableId: selectedServiceType == 'dine_in' ? selectedTable!.id : null,
      customerName: _customerController.text,
      userId: userId!,
      serviceType: selectedServiceType!,
      details: cartItems.map((item) {
        return TransactionDetail(
          productId: item.product.id,
          quantity: item.quantity,
          note: item.note,
          flavorId: item.selectedFlavor?.id,
          spicyLevelId: item.selectedSpicyLevel?.id,
        );
      }).toList(),
    );

    context.read<PendingTransactionBloc>().add(
      PendingTransactionEvent.createTransaction(request: request),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PendingTransactionBloc, PendingTransactionState>(
      listener: (context, state) {
        state.whenOrNull(
          transactionCreated: (response) {
            // Clear cart after successful order creation
            context.read<CartBloc>().add(const CartEvent.clearCart());

            // Clear form
            _customerController.clear();
            setState(() {
              selectedTable = null;
              selectedServiceType = null;
            });

            // Get cart data for dialog
            final cartState = context.read<CartBloc>().state;
            List<Map<String, dynamic>> cartItems = [];
            double totalPrice = 0;
            int totalQty = 0;

            cartState.whenOrNull(
              updated: (items, price, qty) {
                totalPrice = price;
                totalQty = qty;
                cartItems = items
                    .map(
                      (item) => {
                        'product': item.product,
                        'quantity': item.quantity,
                        'note': item.note,
                        'selectedFlavor': item.selectedFlavor,
                        'selectedSpicyLevel': item.selectedSpicyLevel,
                      },
                    )
                    .toList();
              },
            );

            // Show success dialog
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => TransactionSuccessDialog(
                transactionResponse: response,
                totalPrice: totalPrice,
                totalQty: totalQty,
                serviceTypeName: _getServiceTypeName(),
                cartItems: cartItems,
                onHome: () {
                  Navigator.of(context).pop(); // Close dialog
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const MainPage()),
                    (route) => false,
                  );
                },
              ),
            );
          },
          failure: (message) {
            widget.onValidationError?.call(message);
          },
        );
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ServiceTypeDropdown(
                    onServiceTypeChanged: _onServiceTypeChanged,
                  ),
                ),

                const SizedBox(width: 8),
                // Table Dropdown - only show for Dine In
                if (selectedServiceType == 'dine_in')
                  Expanded(
                    flex: 1,
                    child: TableDropdown(onTableChanged: _onTableChanged),
                  )
                else
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Center(
                        child: Text(
                          selectedServiceType == 'take_away'
                              ? 'Take Away'
                              : selectedServiceType == 'delivery'
                              ? 'Delivery'
                              : 'Pilih Pesanan',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),

            // Customer Name Input
            TextFormField(
              controller: _customerController,
              decoration: InputDecoration(
                labelText: 'Nama Customer',
                labelStyle: const TextStyle(color: AppColors.textSecondary),
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(
                  Icons.person,
                  color: AppColors.textSecondary,
                ),
              ),
              style: const TextStyle(color: AppColors.textPrimary),
            ),
            const SizedBox(height: 16),

            // Create Order Button
            SizedBox(
              width: double.infinity,
              child:
                  BlocBuilder<PendingTransactionBloc, PendingTransactionState>(
                    builder: (context, state) {
                      final isLoading = state.maybeWhen(
                        loading: () => true,
                        orElse: () => false,
                      );

                      return ElevatedButton(
                        onPressed: isLoading ? null : _createOrder,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.surface,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                        ),
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.surface,
                                  ),
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.add_shopping_cart),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Buat Pesanan',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textOnPrimary,
                                        ),
                                  ),
                                ],
                              ),
                      );
                    },
                  ),
            ),
            // const SizedBox(height: 8),
            // Text(
            //   'Pesanan akan disimpan sebagai pending dan dapat dibayar di tab Pembayaran',
            //   style: Theme.of(context).textTheme.bodySmall?.copyWith(
            //     color: AppColors.accent,
            //     fontStyle: FontStyle.italic,
            //   ),
            //   textAlign: TextAlign.center,
            // ),
          ],
        ),
      ),
    );
  }
}
