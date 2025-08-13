import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/bloc/cart/cart_bloc.dart';
import 'package:posmobile/presentations/dashboard/main_page.dart';
import 'package:posmobile/presentations/login/bloc/login_bloc.dart';
import 'package:posmobile/presentations/dashboard/transaction/addtransaction/bloc/add_transaction_bloc.dart';
import 'package:posmobile/presentations/dashboard/transaction/addtransaction/widgets/transaction_success_dialog.dart';
import 'package:posmobile/data/model/request/transaction_model_request.dart';
import 'package:posmobile/shared/config/app_colors.dart';

class PaymentButtonWidget extends StatefulWidget {
  final int? selectedPaymentMethod;
  final String? selectedServiceType;
  final double? paymentAmount;
  final Function(String?)? onValidationError;

  const PaymentButtonWidget({
    super.key,
    required this.selectedPaymentMethod,
    required this.selectedServiceType,
    this.paymentAmount,
    this.onValidationError,
  });

  @override
  State<PaymentButtonWidget> createState() => _PaymentButtonWidgetState();
}

class _PaymentButtonWidgetState extends State<PaymentButtonWidget> {
  String _getPaymentMethodName() {
    switch (widget.selectedPaymentMethod) {
      case 1:
        return 'Tunai';
      case 2:
        return 'QRIS';
      case 3:
        return 'Kartu Debit';
      case 4:
        return 'Kartu Kredit';
      default:
        return 'Tidak Diketahui';
    }
  }

  String _getServiceTypeName() {
    switch (widget.selectedServiceType) {
      case 'dine_in':
        return 'Dine In';
      case 'take_away':
        return 'Take Away';
      case 'delivery':
        return 'Delivery';
      default:
        return widget.selectedServiceType?.toUpperCase() ?? 'Tidak Diketahui';
    }
  }

  double? _calculateChange(double totalPrice) {
    if (widget.selectedPaymentMethod == 1 && widget.paymentAmount != null) {
      final change = widget.paymentAmount! - totalPrice;
      return change > 0 ? change : 0;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddTransactionBloc, AddTransactionState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          loading: () {},
          success: (response) {
            // Haptic feedback untuk success
            HapticFeedback.lightImpact();

            // Simpan data cart sebelum di-clear
            final cartState = context.read<CartBloc>().state;
            double? totalPrice;
            int? totalQty;
            List<Map<String, dynamic>>? cartItems;

            cartState.whenOrNull(
              updated: (items, price, qty) {
                totalPrice = price;
                totalQty = qty;
                // Convert cart items to simple map for receipt
                cartItems = items
                    .map(
                      (item) => {
                        'name': item.product.name,
                        'quantity': item.quantity,
                        'price': item.product.price,
                        'note': item.note,
                        'flavor': item.selectedFlavor?.name,
                        'spicyLevel': item.selectedSpicyLevel?.name,
                      },
                    )
                    .toList();
              },
            );

            // Get payment and service info
            final paymentMethodName = _getPaymentMethodName();
            final serviceTypeName = _getServiceTypeName();
            final paymentAmount = widget.selectedPaymentMethod == 1
                ? widget.paymentAmount
                : null;
            final changeAmount = _calculateChange(totalPrice ?? 0);

            // Clear cart setelah data disimpan
            context.read<CartBloc>().add(const CartEvent.clearCart());

            // Clear validation error jika ada
            if (widget.onValidationError != null) {
              widget.onValidationError!(null);
            }

            // Tampilkan success dialog dengan animation
            Future.delayed(const Duration(milliseconds: 300), () {
              if (mounted) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => TransactionSuccessDialog(
                    transactionResponse: response,
                    totalPrice: totalPrice ?? 0,
                    totalQty: totalQty ?? 0,
                    paymentMethodName: paymentMethodName,
                    serviceTypeName: serviceTypeName,
                    paymentAmount: paymentAmount,
                    changeAmount: changeAmount,
                    cartItems: cartItems,
                    onPrint: () {
                      HapticFeedback.selectionClick();
                      Navigator.of(context).pop(); // Close dialog
                      // Navigate to transaction cart for printing
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainPage(),
                        ),
                      );
                    },
                    onHome: () {
                      HapticFeedback.selectionClick();
                      Navigator.of(context).pop(); // Close dialog
                      // Navigate to main/home
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainPage(),
                        ),
                      );
                    },
                  ),
                );
              }
            });
          },
          failure: (message) {
            Flushbar(
              title: "Gagal",
              message: message,
              duration: const Duration(seconds: 3),
              flushbarStyle: FlushbarStyle.FLOATING,
              flushbarPosition: FlushbarPosition.TOP,
              textDirection: Directionality.of(context),
              borderRadius: BorderRadius.circular(12),
              leftBarIndicatorColor: AppColors.success,
            ).show(context);
          },
        );
      },
      builder: (context, state) {
        return state.when(
          initial: () => _buildButton(context, isLoading: false),
          loading: () => _buildButton(context, isLoading: true),
          success: (_) => _buildButton(context, isLoading: false),
          failure: (_) => _buildButton(context, isLoading: false),
        );
      },
    );
  }

  Widget _buildButton(BuildContext context, {bool isLoading = false}) {
    return ElevatedButton(
      onPressed: isLoading ? null : () => _handlePayment(context),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: isLoading ? Colors.grey[400] : AppColors.primary,
        disabledBackgroundColor: Colors.grey[400],
      ),
      child: isLoading
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  "Memproses...",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          : const Text(
              "Bayar Sekarang",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
    );
  }

  void _handlePayment(BuildContext context) {
    // Validasi dan kirim error ke parent widget
    if (widget.selectedPaymentMethod == null) {
      HapticFeedback.lightImpact();
      if (widget.onValidationError != null) {
        widget.onValidationError!("paymentMethod");
      }
      return;
    }

    if (widget.selectedServiceType == null) {
      HapticFeedback.lightImpact();
      if (widget.onValidationError != null) {
        widget.onValidationError!("serviceType");
      }
      return;
    }

    if (widget.selectedPaymentMethod == 1 &&
        (widget.paymentAmount == null || widget.paymentAmount! < 1)) {
      HapticFeedback.lightImpact();
      if (widget.onValidationError != null) {
        widget.onValidationError!("paymentAmount");
      }
      return;
    }

    // Haptic feedback untuk submit
    HapticFeedback.mediumImpact();

    // Clear error jika validasi berhasil
    if (widget.onValidationError != null) {
      widget.onValidationError!(null);
    }

    final cartState = context.read<CartBloc>().state;

    cartState.when(
      initial: () {},
      updated: (items, totalPrice, totalQty) {
        // Ambil user ID dari LoginBloc response
        final loginState = context.read<LoginBloc>().state;
        final userId = loginState.maybeWhen(
          success: (loginResponse) => loginResponse.data.userId,
          orElse: () => 1, // Default userId jika tidak ada login state
        );

        final transaction = TransactionModelRequest(
          userId: userId,
          paymentMethodId: widget.selectedPaymentMethod!,
          paymentAmount: widget.selectedPaymentMethod == 1
              ? widget.paymentAmount!.toInt()
              : totalPrice.toInt(),
          serviceType: widget.selectedServiceType!,
          details: items
              .map(
                (item) => Detail(
                  productId: item.product.id,
                  quantity: item.quantity,
                  note: item.note ?? "",
                  flavorId: item.selectedFlavor?.id,
                  spicyLevelId: item.selectedSpicyLevel?.id,
                ),
              )
              .toList(),
        );

        context.read<AddTransactionBloc>().add(
          AddTransactionEvent.addTransaction(req: transaction),
        );
      },
    );
  }
}
