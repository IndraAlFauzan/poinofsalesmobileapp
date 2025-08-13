import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/bloc/cart/cart_bloc.dart';
import 'package:posmobile/shared/widgets/idr_format.dart';

class CashPaymentWidget extends StatelessWidget {
  final int? selectedPaymentMethod;
  final Function(double) onPaymentAmountChanged;
  final double? changeAmount;

  const CashPaymentWidget({
    super.key,
    required this.selectedPaymentMethod,
    required this.onPaymentAmountChanged,
    this.changeAmount,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedPaymentMethod != 1) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<CartBloc, CartState>(
          builder: (context, cartState) {
            return cartState.when(
              initial: () => TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  CurrencyTextInputFormatter.currency(
                    locale: 'id',
                    decimalDigits: 0,
                    symbol: 'Rp',
                  ),
                ],
                decoration: InputDecoration(
                  hintText: "Masukkan Uang Pelanggan",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                ),
                onChanged: (value) {
                  String cleanedValue = value.replaceAll(RegExp(r'[^0-9]'), '');
                  double paymentAmount = double.tryParse(cleanedValue) ?? 0;
                  onPaymentAmountChanged(paymentAmount);
                },
              ),
              updated: (items, totalPrice, totalQty) {
                return TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    CurrencyTextInputFormatter.currency(
                      locale: 'id',
                      decimalDigits: 0,
                      symbol: 'Rp',
                    ),
                  ],
                  decoration: InputDecoration(
                    hintText: "Masukkan Uang Pelanggan",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                  ),
                  onChanged: (value) {
                    String cleanedValue = value.replaceAll(
                      RegExp(r'[^0-9]'),
                      '',
                    );
                    double paymentAmount = double.tryParse(cleanedValue) ?? 0;
                    onPaymentAmountChanged(paymentAmount);
                  },
                );
              },
            );
          },
        ),
        const SizedBox(height: 16),
        BlocBuilder<CartBloc, CartState>(
          builder: (context, cartState) {
            return cartState.when(
              initial: () => const SizedBox(),
              updated: (items, totalPrice, totalQty) {
                return Text(
                  "Kembalian: ${idrFormat(changeAmount ?? 0)}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
