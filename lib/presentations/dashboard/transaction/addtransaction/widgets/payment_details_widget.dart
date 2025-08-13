import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/bloc/cart/cart_bloc.dart';
import 'package:posmobile/bloc/payment_method/payment_method_bloc.dart';
import 'package:posmobile/presentations/dashboard/transaction/addtransaction/widgets/order_items_list_widget.dart';
import 'package:posmobile/presentations/dashboard/transaction/addtransaction/widgets/payment_method_dropdown.dart';
import 'package:posmobile/presentations/dashboard/transaction/addtransaction/widgets/service_type_dropdown.dart';
import 'package:posmobile/presentations/dashboard/transaction/addtransaction/widgets/order_summary_widget.dart';
import 'package:posmobile/presentations/dashboard/transaction/addtransaction/widgets/cash_payment_widget.dart';
import 'package:posmobile/presentations/dashboard/transaction/addtransaction/widgets/payment_button_widget.dart';

class PaymentDetailsWidget extends StatefulWidget {
  const PaymentDetailsWidget({super.key});

  @override
  State<PaymentDetailsWidget> createState() => _PaymentDetailsWidgetState();
}

class _PaymentDetailsWidgetState extends State<PaymentDetailsWidget> {
  double? paymentAmount;
  double? changeAmount;
  int? selectedPaymentMethod;
  String? selectedServiceType;
  String? validationError;

  @override
  void initState() {
    super.initState();
    // Fetch payment methods saat halaman dimuat
    context.read<PaymentMethodBloc>().add(
      PaymentMethodEvent.fetchPaymentMethods(),
    );
  }

  void _onValidationError(String? errorType) {
    setState(() {
      validationError = errorType;
    });
  }

  void _onPaymentAmountChanged(double amount) {
    setState(() {
      paymentAmount = amount;
      // Calculate change based on cart total
      final cartState = context.read<CartBloc>().state;
      cartState.when(
        initial: () => changeAmount = amount,
        updated: (items, totalPrice, totalQty) {
          changeAmount = amount - totalPrice;
        },
      );
    });
  }

  void _onPaymentMethodChanged(int? methodId) {
    setState(() {
      selectedPaymentMethod = methodId;
      // Reset payment amount when changing method
      if (methodId != 1) {
        paymentAmount = null;
        changeAmount = null;
      }
    });
  }

  void _onServiceTypeChanged(String? serviceType) {
    setState(() {
      selectedServiceType = serviceType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // List item pesanan menggunakan widget terpisah
            const Expanded(flex: 3, child: OrderItemsListWidget()),
            const SizedBox(height: 16),
            PaymentMethodDropdown(
              onPaymentMethodChanged: _onPaymentMethodChanged,
            ),
            if (validationError == "paymentMethod")
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  "Pilih metode pembayaran",
                  style: TextStyle(
                    color: Colors.red[600],
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            ServiceTypeDropdown(onServiceTypeChanged: _onServiceTypeChanged),
            if (validationError == "serviceType")
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  "Pilih tipe layanan",
                  style: TextStyle(
                    color: Colors.red[600],
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            const OrderSummaryWidget(),
            const SizedBox(height: 16),
            CashPaymentWidget(
              selectedPaymentMethod: selectedPaymentMethod,
              onPaymentAmountChanged: _onPaymentAmountChanged,
              changeAmount: changeAmount,
            ),
            if (validationError == "paymentAmount")
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  "Masukkan jumlah uang",
                  style: TextStyle(
                    color: Colors.red[600],
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            PaymentButtonWidget(
              selectedPaymentMethod: selectedPaymentMethod,
              selectedServiceType: selectedServiceType,
              paymentAmount: paymentAmount,
              onValidationError: _onValidationError,
            ),
          ],
        ),
      ),
    );
  }
}
