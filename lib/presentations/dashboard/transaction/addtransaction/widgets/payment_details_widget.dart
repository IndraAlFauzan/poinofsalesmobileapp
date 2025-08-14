import 'package:flutter/material.dart';
import 'package:posmobile/presentations/dashboard/transaction/addtransaction/widgets/transaction_items_list_widget.dart';
import 'package:posmobile/presentations/dashboard/transaction/addtransaction/widgets/transaction_summary_widget.dart';
import 'package:posmobile/presentations/dashboard/transaction/addtransaction/widgets/create_transaction_button_widget.dart';

class PaymentDetailsWidget extends StatefulWidget {
  const PaymentDetailsWidget({super.key});

  @override
  State<PaymentDetailsWidget> createState() => _PaymentDetailsWidgetState();
}

class _PaymentDetailsWidgetState extends State<PaymentDetailsWidget> {
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
            const Expanded(flex: 3, child: TransactionItemsListWidget()),
            const TransactionSummaryWidget(),
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
