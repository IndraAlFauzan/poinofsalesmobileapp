import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/bloc/cart/cart_bloc.dart';
import 'package:posmobile/bloc/pending_transaction/pending_transaction_bloc.dart';
import 'package:posmobile/presentations/dashboard/transaction/addtransaction/widgets/service_type_dropdown.dart';
import 'package:posmobile/presentations/login/bloc/login_bloc.dart';
import 'package:posmobile/data/model/request/create_transaction_request.dart';
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
  final _tableController = TextEditingController();
  final _customerController = TextEditingController();
  String? selectedServiceType;

  @override
  void dispose() {
    _tableController.dispose();
    _customerController.dispose();
    super.dispose();
  }

  void _onServiceTypeChanged(String? serviceType) {
    setState(() {
      selectedServiceType = serviceType;
    });
  }

  void _createOrder() {
    // Validation
    if (selectedServiceType == null) {
      widget.onValidationError?.call('Pilih tipe layanan terlebih dahulu');
      return;
    }

    if (_tableController.text.isEmpty) {
      widget.onValidationError?.call('Masukkan nomor meja');
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
      tableId: int.tryParse(_tableController.text) ?? 1,
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
            _tableController.clear();
            _customerController.clear();

            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Pesanan ${response.data.orderNo} berhasil dibuat',
                ),
                backgroundColor: Colors.green,
              ),
            );
          },
          failure: (message) {
            widget.onValidationError?.call(message);
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ServiceTypeDropdown(onServiceTypeChanged: _onServiceTypeChanged),

          const SizedBox(height: 16),
          // Table Number Input
          TextFormField(
            controller: _tableController,
            decoration: InputDecoration(
              labelText: 'Nomor Meja',
              labelStyle: const TextStyle(color: AppColors.textSecondary),
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(
                Icons.table_restaurant,
                color: AppColors.textSecondary,
              ),
            ),
            style: const TextStyle(color: AppColors.textPrimary),
            keyboardType: TextInputType.number,
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
            child: BlocBuilder<PendingTransactionBloc, PendingTransactionState>(
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
                              style: Theme.of(context).textTheme.titleMedium
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
          const SizedBox(height: 8),
          Text(
            'Pesanan akan disimpan sebagai pending dan dapat dibayar di tab Pembayaran',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textPrimary,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
