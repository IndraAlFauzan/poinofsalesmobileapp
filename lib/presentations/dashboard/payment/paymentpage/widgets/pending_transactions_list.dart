import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/bloc/pending_transaction/pending_transaction_bloc.dart';
import 'package:posmobile/presentations/dashboard/payment/paymentpage/bloc/payment_page_bloc.dart';
import 'package:posmobile/presentations/dashboard/payment/paymentpage/widgets/table_filter_dropdown.dart';
import 'package:posmobile/presentations/dashboard/payment/paymentpage/widgets/transaction_card.dart';
import 'package:posmobile/shared/config/app_colors.dart';
import 'package:posmobile/shared/config/theme_extensions.dart';
import 'package:posmobile/shared/widgets/adaptive_widgets.dart';

class PendingTransactionsList extends StatelessWidget {
  const PendingTransactionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveCard(
      child: Padding(
        padding: EdgeInsets.all(context.spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            SizedBox(height: context.spacing.md),
            const TableFilterDropdown(),
            SizedBox(height: context.spacing.md),
            Expanded(child: _buildTransactionsList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(context.spacing.sm),
          decoration: BoxDecoration(
            color: context.colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(context.radius.sm),
          ),
          child: Icon(
            Icons.pending_actions_rounded,
            color: AppColors.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'Pesanan Pending',
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const Spacer(),
        BlocBuilder<PendingTransactionBloc, PendingTransactionState>(
          builder: (context, state) {
            final isRefreshing = state.maybeWhen(
              loading: () => true,
              orElse: () => false,
            );

            return Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  onPressed: isRefreshing
                      ? null
                      : () {
                          context.read<PendingTransactionBloc>().add(
                            const PendingTransactionEvent.fetchPendingTransactions(),
                          );
                        },
                  icon: Icon(
                    Icons.refresh_rounded,
                    color: isRefreshing ? Colors.grey : AppColors.primary,
                  ),
                  tooltip: 'Refresh Data',
                ),
                if (isRefreshing)
                  Positioned(
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primary,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildTransactionsList() {
    return BlocConsumer<PendingTransactionBloc, PendingTransactionState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (transactions) {
            // Update payment page bloc with new transactions
            context.read<PaymentPageBloc>().add(
              PaymentPageEvent.updateTransactions(transactions: transactions),
            );
          },
          transactionUpdated: (response) {
            // Refresh transactions when a transaction is updated
            context.read<PendingTransactionBloc>().add(
              const PendingTransactionEvent.fetchPendingTransactions(),
            );
          },
        );
      },
      builder: (context, state) {
        return state.when(
          initial: () => _buildEmptyState('Belum ada pesanan pending'),
          loading: () => const Center(child: CircularProgressIndicator()),
          success: (transactions) {
            // Always update PaymentPageBloc with fresh data
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<PaymentPageBloc>().add(
                PaymentPageEvent.updateTransactions(transactions: transactions),
              );
            });

            return BlocBuilder<PaymentPageBloc, PaymentPageState>(
              builder: (context, paymentState) {
                return paymentState.when(
                  initial: () => _buildEmptyState('Memuat data...'),
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
                        final paymentPageBloc = context.read<PaymentPageBloc>();
                        final displayTransactions = paymentPageBloc
                            .getFilteredTransactions();

                        if (displayTransactions.isEmpty) {
                          return selectedTableNo != null
                              ? _buildEmptyState(
                                  'Tidak ada pesanan di Meja $selectedTableNo',
                                )
                              : _buildEmptyState('Belum ada pesanan pending');
                        }

                        return ListView.builder(
                          itemCount: displayTransactions.length,
                          itemBuilder: (context, index) {
                            final transaction = displayTransactions[index];
                            return PaymentTransactionPendingCard(
                              transaction: transaction,
                            );
                          },
                        );
                      },
                );
              },
            );
          },
          failure: (message) => _buildErrorState(context, message),
          transactionCreated: (_) => const SizedBox.shrink(),
          transactionUpdated: (_) => const SizedBox.shrink(),
        );
      },
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.pending_actions_outlined,
              size: 48,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: Colors.red[400]),
          const SizedBox(height: 16),
          Text(
            'Error: $message',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red[600]),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              context.read<PendingTransactionBloc>().add(
                const PendingTransactionEvent.fetchPendingTransactions(),
              );
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Coba Lagi'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
