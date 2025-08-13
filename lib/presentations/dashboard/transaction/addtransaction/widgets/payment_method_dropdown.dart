import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/bloc/payment_method/payment_method_bloc.dart';

class PaymentMethodDropdown extends StatelessWidget {
  final Function(int?) onPaymentMethodChanged;

  const PaymentMethodDropdown({
    super.key,
    required this.onPaymentMethodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentMethodBloc, PaymentMethodState>(
      listener: (context, state) {
        state.when(
          initial: () {},
          loading: () {},
          success: (paymentMethods) {},
          failure: (message) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message)));
          },
        );
      },
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox(),
          loading: () => const Center(child: CircularProgressIndicator()),
          failure: (message) => Center(child: Text("Error: $message")),
          success: (paymentMethods) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Pilih Metode Pembayaran",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                CustomDropdown<String>(
                  hintText: "Metode Pembayaran",
                  decoration: CustomDropdownDecoration(
                    closedBorder: Border.all(color: Colors.grey),
                  ),
                  items: paymentMethods.map((method) => method.name).toList(),
                  onChanged: (value) {
                    final selectedMethod = paymentMethods.firstWhere(
                      (method) => method.name == value,
                      orElse: () => paymentMethods.first,
                    );
                    onPaymentMethodChanged(selectedMethod.id);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
