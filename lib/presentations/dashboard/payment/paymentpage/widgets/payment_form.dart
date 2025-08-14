import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/bloc/payment_method/payment_method_bloc.dart';
import 'package:posmobile/bloc/payment_settlement/payment_settlement_bloc.dart';
import 'package:posmobile/data/model/request/payment_settle_request.dart';
import 'package:posmobile/presentations/dashboard/payment/paymentpage/bloc/payment_page_bloc.dart';
import 'package:posmobile/shared/config/app_colors.dart';
import 'package:posmobile/shared/widgets/idr_format.dart';

class PaymentForm extends StatefulWidget {
  const PaymentForm({super.key});

  @override
  State<PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Jumlah uang tidak valid')),
        );
        return;
      }
    }

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
          },
        );
      },
      child: Container(
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              const _SelectedTransactionsSummary(),
              const SizedBox(height: 20),
              _buildPaymentMethodSelection(),
              if (_selectedPaymentMethodId == 1) ...[
                const SizedBox(height: 16),
                _buildCashAmountField(),
              ],
              const SizedBox(height: 16),
              _buildNoteField(),
              const Spacer(),
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
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.payment_rounded,
            color: AppColors.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'Form Pembayaran',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextFormField(
        controller: _tenderedAmountController,
        decoration: const InputDecoration(
          labelText: 'Jumlah Uang Diterima',
          prefixIcon: Icon(Icons.attach_money_rounded),
          prefixText: 'Rp ',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16),
        ),
        keyboardType: TextInputType.number,
      ),
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
        maxLines: 3,
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

class _SelectedTransactionsSummary extends StatelessWidget {
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
                              Text(
                                idrFormat(transaction.grandTotal),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Pembayaran:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            idrFormat(totalAmount.toString()),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: AppColors.primary,
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
