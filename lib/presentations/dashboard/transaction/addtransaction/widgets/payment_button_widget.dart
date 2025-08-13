import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/bloc/cart/cart_bloc.dart';
import 'package:posmobile/presentations/dashboard/transaction/transactioncart/transaction_cart_page.dart';
import 'package:posmobile/presentations/login/bloc/login_bloc.dart';
import 'package:posmobile/presentations/dashboard/transaction/addtransaction/bloc/add_transaction_bloc.dart';
import 'package:posmobile/data/model/request/transaction_model_request.dart';
import 'package:posmobile/shared/config/app_colors.dart';
import 'package:posmobile/shared/widgets/custom_alert_dialog.dart';

class PaymentButtonWidget extends StatelessWidget {
  final int? selectedPaymentMethod;
  final String? selectedServiceType;
  final double? paymentAmount;

  const PaymentButtonWidget({
    super.key,
    required this.selectedPaymentMethod,
    required this.selectedServiceType,
    this.paymentAmount,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddTransactionBloc, AddTransactionState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          loading: () {},
          success: (response) {
            // Tampilkan notifikasi sukses
            Flushbar(
              title: "Sukses",
              message: "Transaksi berhasil ditambahkan",
              duration: const Duration(seconds: 4),
              flushbarStyle: FlushbarStyle.FLOATING,
              flushbarPosition: FlushbarPosition.TOP,
              textDirection: Directionality.of(context),
              borderRadius: BorderRadius.circular(12),
              leftBarIndicatorColor: Colors.blue[300],
            ).show(context);

            // Clear cart
            context.read<CartBloc>().add(const CartEvent.clearCart());

            // Tampilkan dialog setelah reset
            Future.delayed(Duration.zero, () {
              showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CustomAlertDialog(
                    title: 'Berhasil',
                    content: 'Apakah Anda yakin ingin print?',
                    cancelText: 'Home',
                    confirmText: 'Print',
                    onCancel: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/main',
                        (route) => false,
                      );
                    },
                    onConfirm: () {
                      //back to transaction cart
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TransactionCartPage(),
                        ),
                      );
                    },
                  );
                },
              );
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
              leftBarIndicatorColor: Colors.red[300],
            ).show(context);
          },
        );
      },
      builder: (context, state) {
        return state.when(
          initial: () => _buildButton(context),
          loading: () => const Center(child: CircularProgressIndicator()),
          success: (_) => _buildButton(context),
          failure: (_) => _buildButton(context),
        );
      },
    );
  }

  Widget _buildButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _handlePayment(context),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: AppColors.primary,
      ),
      child: const Text(
        "Bayar Sekarang",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  void _handlePayment(BuildContext context) {
    if (selectedPaymentMethod == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Pilih metode pembayaran")));
      return;
    }

    if (selectedServiceType == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Pilih tipe layanan")));
      return;
    }

    if (selectedPaymentMethod == 1 &&
        (paymentAmount == null || paymentAmount! < 1)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Masukkan jumlah uang")));
      return;
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
          paymentMethodId: selectedPaymentMethod!,
          paymentAmount: selectedPaymentMethod == 1
              ? paymentAmount!.toInt()
              : totalPrice.toInt(),
          serviceType: selectedServiceType!,
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
