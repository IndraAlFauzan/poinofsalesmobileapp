import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/bloc/payment_method/payment_method_bloc.dart';
import 'package:posmobile/bloc/payment_settlement/payment_settlement_bloc.dart';
import 'package:posmobile/data/model/request/payment_settle_request.dart';
import 'package:posmobile/presentations/dashboard/payment/paymentpage/bloc/payment_page_bloc.dart';
import 'package:posmobile/presentations/dashboard/payment/paymentpage/widgets/payment_gateway_webview.dart';
import 'package:posmobile/shared/config/app_colors.dart';
import 'package:posmobile/shared/widgets/idr_format.dart';
import 'package:posmobile/shared/mixins/responsive_mixin.dart';
import 'package:posmobile/shared/config/theme_extensions.dart';
import 'package:posmobile/shared/widgets/adaptive_widgets.dart';

class PaymentForm extends StatefulWidget {
  const PaymentForm({super.key});

  @override
  State<PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> with ResponsiveMixin {
  int? _selectedPaymentMethodId;
  final _tenderedAmountController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _tenderedAmountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _processPayment() {
    final paymentPageBloc = context.read<PaymentPageBloc>();
    final state = paymentPageBloc.state;

    final selectedTransactions =
        state.whenOrNull(
          loaded:
              (
                allTransactions,
                selectedTableNo,
                selectedTransactions,
                availableTables,
                paymentMethodId,
                paymentMethodName,
                tenderedAmount,
                note,
              ) => selectedTransactions,
        ) ??
        [];

    if (selectedTransactions.isEmpty) {
      Flushbar(
        message: 'Pilih pesanan yang akan dibayar',
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red,
        flushbarStyle: FlushbarStyle.GROUNDED,
      ).show(context);
      return;
    }

    if (_selectedPaymentMethodId == null) {
      Flushbar(
        message: 'Pilih metode pembayaran',
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red,
        flushbarStyle: FlushbarStyle.GROUNDED,
      ).show(context);
      return;
    }

    // For cash payment, validate tendered amount
    if (_selectedPaymentMethodId == 1) {
      final tenderedAmount = double.tryParse(_tenderedAmountController.text);
      final totalAmount = paymentPageBloc.getTotalAmount();

      if (tenderedAmount == null || tenderedAmount < totalAmount) {
        Flushbar(
          message: 'Jumlah uang tidak mencukupi',
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
          flushbarStyle: FlushbarStyle.GROUNDED,
        ).show(context);
        return;
      }
    }

    // Store payment info to bloc before processing payment
    // First get payment method name
    final paymentMethodBloc = context.read<PaymentMethodBloc>();
    String paymentMethodName = 'Unknown';
    paymentMethodBloc.state.whenOrNull(
      success: (paymentMethods) {
        final method = paymentMethods.firstWhere(
          (m) => m.id == _selectedPaymentMethodId,
          orElse: () => paymentMethods.first,
        );
        paymentMethodName = method.name;
      },
    );

    // Save payment info to bloc
    context.read<PaymentPageBloc>().add(
      PaymentPageEvent.setPaymentInfo(
        paymentMethodId: _selectedPaymentMethodId!,
        paymentMethodName: paymentMethodName,
        tenderedAmount: _selectedPaymentMethodId == 1
            ? double.tryParse(_tenderedAmountController.text)
            : null,
        note: _noteController.text.isEmpty ? null : _noteController.text,
      ),
    );

    final request = PaymentSettleRequest(
      paymentMethodId: _selectedPaymentMethodId!,
      transactionIds: selectedTransactions.map((t) => t.transactionId).toList(),
      tenderedAmount: _selectedPaymentMethodId == 1
          ? double.tryParse(_tenderedAmountController.text)
          : null,
      note: _noteController.text.isEmpty ? null : _noteController.text,
    );

    context.read<PaymentSettlementBloc>().add(
      PaymentSettlementEvent.settlePayment(request: request),
    );
  }

  void _clearForm() {
    setState(() {
      _selectedPaymentMethodId = null;
      _tenderedAmountController.clear();
      _noteController.clear();
    });
  }

  // void _showPaymentSuccessDialog() {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context) => AlertDialog(
  //       title: const Row(
  //         children: [
  //           Icon(Icons.check_circle, color: Colors.green),
  //           SizedBox(width: 8),
  //           Text('Payment Successful'),
  //         ],
  //       ),
  //       content: const Text('Cash payment has been processed successfully!'),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(),
  //           child: const Text('OK'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentSettlementBloc, PaymentSettlementState>(
      listener: (context, state) {
        state.whenOrNull(
          paymentSettled: (response) {
            // Clear form and selections after successful payment
            _clearForm();
            context.read<PaymentPageBloc>().add(
              const PaymentPageEvent.clearSelections(),
            );

            // Check if payment has checkout URL (payment gateway)
            if (response.checkoutUrl != null) {
              // Navigate to webview for payment gateway
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PaymentGatewayWebView(
                    checkoutUrl: response.checkoutUrl!,
                    paymentId: response.data.paymentId,
                  ),
                ),
              );
            } else {
              // Show success dialog for cash payment
              // _showPaymentSuccessDialog();
            }
          },
          failure: (message) {
            Flushbar(
              message: 'Payment failed: $message',
              duration: const Duration(seconds: 3),
              backgroundColor: Colors.red,
              flushbarStyle: FlushbarStyle.GROUNDED,
            ).show(context);
          },
        );
      },
      child: AdaptiveCard(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(context.spacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              SizedBox(height: context.spacing.lg),
              const _SelectedTransactionsSummary(),
              SizedBox(height: context.spacing.lg),
              _buildPaymentMethodSelection(),
              if (_selectedPaymentMethodId == 1) ...[
                SizedBox(height: context.spacing.md),
                _buildCashAmountField(),
              ],
              SizedBox(height: context.spacing.md),
              _buildNoteField(),
              SizedBox(height: context.spacing.lg),
              _buildPaymentButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(context.spacing.sm),
          decoration: BoxDecoration(
            color: context.colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(context.radius.sm),
          ),
          child: Icon(
            Icons.payment_rounded,
            color: context.colorScheme.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'Form Pembayaran',
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodSelection() {
    return BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const Center(child: CircularProgressIndicator()),
          success: (paymentMethods) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: DropdownButtonFormField<int>(
              value: _selectedPaymentMethodId,
              decoration: const InputDecoration(
                labelText: 'Metode Pembayaran',
                prefixIcon: Icon(Icons.credit_card_rounded),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
              ),
              items: paymentMethods
                  .map(
                    (method) => DropdownMenuItem(
                      value: method.id,
                      child: Text(method.name),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethodId = value;
                });
              },
            ),
          ),
          failure: (message) => Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.red[200]!),
            ),
            child: Row(
              children: [
                Icon(Icons.error_outline, color: Colors.red[600]),
                const SizedBox(width: 8),
                Text(
                  'Error: $message',
                  style: TextStyle(color: Colors.red[600]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCashAmountField() {
    return BlocBuilder<PaymentPageBloc, PaymentPageState>(
      builder: (context, state) {
        final paymentPageBloc = context.read<PaymentPageBloc>();
        final totalAmount = paymentPageBloc.getTotalAmount();
        final tenderedAmount =
            double.tryParse(_tenderedAmountController.text) ?? 0.0;
        final changeAmount = tenderedAmount > totalAmount
            ? tenderedAmount - totalAmount
            : 0.0;

        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: TextFormField(
                controller: _tenderedAmountController,
                decoration: const InputDecoration(
                  labelText: 'Jumlah Uang Diterima',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                  prefixText: 'Rp ',
                ),

                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {}); // Trigger rebuild untuk update kembalian
                },
              ),
            ),
            if (tenderedAmount > 0) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: changeAmount >= 0
                      ? Colors.green.withValues(alpha: 0.1)
                      : Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: changeAmount >= 0
                        ? Colors.green.withValues(alpha: 0.3)
                        : Colors.red.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              changeAmount >= 0
                                  ? Icons.check_circle
                                  : Icons.warning,
                              size: 16,
                              color: changeAmount >= 0
                                  ? Colors.green[600]
                                  : Colors.red[600],
                            ),
                            const SizedBox(width: 8),
                            Text(
                              changeAmount >= 0 ? 'Kembalian:' : 'Kurang:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: changeAmount >= 0
                                    ? Colors.green[600]
                                    : Colors.red[600],
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        priceText(
                          idrFormat(changeAmount.abs().toString()),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: changeAmount >= 0
                                ? Colors.green[600]
                                : Colors.red[600],
                            fontSize: 18,
                          ),
                          context: context,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildNoteField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextFormField(
        controller: _noteController,
        decoration: const InputDecoration(
          labelText: 'Catatan (Opsional)',
          prefixIcon: Icon(Icons.note_rounded),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _buildPaymentButton() {
    return SizedBox(
      width: double.infinity,
      child: BlocBuilder<PaymentSettlementBloc, PaymentSettlementState>(
        builder: (context, state) {
          final isLoading = state.maybeWhen(
            loading: () => true,
            orElse: () => false,
          );

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.primary.withValues(alpha: 0.8),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: isLoading ? null : _processPayment,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.payment_rounded, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Proses Pembayaran',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}

class _SelectedTransactionsSummary extends StatelessWidget
    with ResponsiveMixin {
  const _SelectedTransactionsSummary();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentPageBloc, PaymentPageState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loaded:
              (
                allTransactions,
                selectedTableNo,
                selectedTransactions,
                availableTables,
                paymentMethodId,
                paymentMethodName,
                tenderedAmount,
                note,
              ) {
                if (selectedTransactions.isEmpty) {
                  return const SizedBox.shrink();
                }

                final paymentPageBloc = context.read<PaymentPageBloc>();
                final totalAmount = paymentPageBloc.getTotalAmount();

                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.05),
                        AppColors.primary.withValues(alpha: 0.02),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.shopping_cart_rounded,
                            size: 16,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Pesanan dipilih (${selectedTransactions.length}):',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ...selectedTransactions.map(
                        (transaction) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  '${transaction.orderNo} - ${transaction.customerName}',
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                              priceText(
                                idrFormat(transaction.grandTotal),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                                context: context,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Total Pembayaran:',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Flexible(
                            child: priceText(
                              idrFormat(totalAmount.toString()),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: AppColors.primary,
                              ),
                              context: context,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
        );
      },
    );
  }
}
