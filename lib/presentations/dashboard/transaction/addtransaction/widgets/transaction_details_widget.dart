import 'package:flutter/material.dart';
import 'package:posmobile/presentations/dashboard/transaction/addtransaction/widgets/transaction_items_list_widget.dart';
import 'package:posmobile/presentations/dashboard/transaction/addtransaction/widgets/transaction_summary_widget.dart';
import 'package:posmobile/presentations/dashboard/transaction/addtransaction/widgets/create_transaction_button_widget.dart';
import 'package:posmobile/shared/config/app_colors.dart';

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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.receipt_long,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Detail Pesanan',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // List item pesanan
              SizedBox(
                height: 300, // Fixed height for the items list
                child: const TransactionItemsListWidget(),
              ),

              const SizedBox(height: 16),

              // Transaction summary section
              const TransactionSummaryWidget(),
              const SizedBox(height: 20),

              // Create transaction form dan button
              CreateTransactionButtonWidget(
                onValidationError: _onValidationError,
              ),

              // Error message display
              if (validationError != null && validationError != "serviceType")
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Colors.red[600],
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          validationError!,
                          style: TextStyle(
                            color: Colors.red[600],
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
