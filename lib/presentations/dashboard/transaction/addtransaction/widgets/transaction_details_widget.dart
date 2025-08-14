import 'package:flutter/material.dart';
import 'package:posmobile/presentations/dashboard/transaction/addtransaction/widgets/order_items_list_widget.dart';
import 'package:posmobile/presentations/dashboard/transaction/addtransaction/widgets/order_summary_widget.dart';
import 'package:posmobile/presentations/dashboard/transaction/addtransaction/widgets/create_transaction_button_widget.dart';

class TransactionDetailsWidget extends StatefulWidget {
  const TransactionDetailsWidget({super.key});

  @override
  State<TransactionDetailsWidget> createState() =>
      _TransactionDetailsWidgetState();
}

class _TransactionDetailsWidgetState extends State<TransactionDetailsWidget> {
  String? validationError;

  @override
  void initState() {
    super.initState();
  }

  void _onValidationError(String? errorType) {
    setState(() {
      validationError = errorType;
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
            const OrderSummaryWidget(),
            const SizedBox(height: 16),
            CreateTransactionButtonWidget(
              onValidationError: _onValidationError,
            ),
            if (validationError != null && validationError != "serviceType")
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  validationError!,
                  style: TextStyle(
                    color: Colors.red[600],
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
