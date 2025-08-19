import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/bloc/pending_transaction/pending_transaction_bloc.dart';
import 'package:posmobile/bloc/payment_settlement/payment_settlement_bloc.dart';
import 'package:posmobile/bloc/payment_method/payment_method_bloc.dart';
import 'package:posmobile/data/model/response/pending_transactions_response.dart';
import 'package:posmobile/presentations/dashboard/payment/paymentpage/widgets/payment_success_dialog.dart';
import 'package:posmobile/presentations/dashboard/payment/paymentpage/widgets/pending_transactions_list.dart';
import 'package:posmobile/presentations/dashboard/payment/paymentpage/widgets/payment_form.dart';
import 'package:posmobile/presentations/dashboard/payment/paymentpage/bloc/payment_page_bloc.dart';
import 'package:posmobile/shared/widgets/top_bar.dart';
import 'package:posmobile/shared/config/theme_extensions.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentPageBloc(),
      child: const _PaymentPageView(),
    );
  }
}

class _PaymentPageView extends StatefulWidget {
  const _PaymentPageView();

  @override
  State<_PaymentPageView> createState() => _PaymentPageViewState();
}

class _PaymentPageViewState extends State<_PaymentPageView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PendingTransactionBloc>().add(
        const PendingTransactionEvent.fetchPendingTransactions(),
      );
      context.read<PaymentMethodBloc>().add(
        const PaymentMethodEvent.fetchPaymentMethods(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: context.colorScheme.surface,
        resizeToAvoidBottomInset: true, // Penting untuk handle keyboard
        body: BlocListener<PaymentSettlementBloc, PaymentSettlementState>(
          listener: _handlePaymentSettlement,
          child: Column(
            children: [
              TopBar(hintText: 'Cari Pesanan...'),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(context.spacing.md),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight:
                          MediaQuery.of(context).size.height -
                          160, // Account for TopBar and padding
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left side - Pending transactions list
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height - 160,
                            child: const PendingTransactionsList(),
                          ),
                        ),
                        SizedBox(width: context.spacing.md),
                        // Right side - Payment form
                        BlocBuilder<PaymentPageBloc, PaymentPageState>(
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
                                    if (selectedTransactions.isNotEmpty) {
                                      return Expanded(
                                        flex: 1,
                                        child: SizedBox(
                                          height:
                                              MediaQuery.of(
                                                context,
                                              ).size.height -
                                              160,
                                          child: const PaymentForm(),
                                        ),
                                      );
                                    }
                                    return const SizedBox.shrink();
                                  },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handlePaymentSettlement(
    BuildContext context,
    PaymentSettlementState state,
  ) {
    state.whenOrNull(
      paymentSettled: (response) {
        // Get selected transactions data before clearing
        final paymentPageBloc = context.read<PaymentPageBloc>();
        final paymentState = paymentPageBloc.state;

        paymentState.whenOrNull(
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
                final currentTotalAmount = paymentPageBloc.getTotalAmount();

                // Store data for receipt
                final paidTransactions = List<PendingTransaction>.from(
                  selectedTransactions,
                );
                final currentPaymentMethod =
                    paymentMethodName ?? 'Unknown Payment Method';
                final currentTenderedAmount = tenderedAmount;
                final currentChangeAmount =
                    currentTenderedAmount != null &&
                        currentTenderedAmount > currentTotalAmount
                    ? currentTenderedAmount - currentTotalAmount
                    : null;

                // Clear selections
                context.read<PaymentPageBloc>().add(
                  const PaymentPageEvent.clearSelections(),
                );

                // Refresh pending transactions
                context.read<PendingTransactionBloc>().add(
                  const PendingTransactionEvent.fetchPendingTransactions(),
                );

                // Show success dialog
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => PaymentSuccessDialog(
                    paymentId: response.data.paymentId,
                    paidTransactions: paidTransactions,
                    totalAmount: currentTotalAmount,
                    paymentMethod: currentPaymentMethod,
                    tenderedAmount: currentTenderedAmount,
                    changeAmount: currentChangeAmount,
                  ),
                );
              },
        );
      },
      failure: (message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(child: Text('Error: $message')),
              ],
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
    );
  }
}
