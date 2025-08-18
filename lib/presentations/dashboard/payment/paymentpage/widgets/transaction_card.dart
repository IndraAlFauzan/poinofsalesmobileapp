import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/bloc/pending_transaction/pending_transaction_bloc.dart';
import 'package:posmobile/data/model/response/pending_transactions_response.dart';
import 'package:posmobile/presentations/dashboard/payment/paymentpage/bloc/payment_page_bloc.dart';
import 'package:posmobile/presentations/dashboard/payment/paymentpage/widgets/add_item_to_transaction_dialog.dart';
import 'package:posmobile/shared/config/app_colors.dart';
import 'package:posmobile/shared/widgets/idr_format.dart';
import 'package:posmobile/shared/widgets/fortmat_datetime.dart';

class TransactionCard extends StatelessWidget {
  final PendingTransaction transaction;

  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PendingTransactionBloc, PendingTransactionState>(
      listener: (context, state) {
        // Force rebuild when PendingTransactionBloc state changes
        state.whenOrNull(
          success: (transactions) {
            // This will trigger rebuild of BlocBuilder below
          },
        );
      },
      child: BlocBuilder<PaymentPageBloc, PaymentPageState>(
        builder: (context, state) {
          final paymentPageBloc = context.read<PaymentPageBloc>();

          // Get the latest transaction data from state
          final latestTransaction =
              paymentPageBloc.getTransactionById(transaction.transactionId) ??
              transaction;
          final isSelected = paymentPageBloc.isTransactionSelected(
            latestTransaction,
          );

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary.withValues(alpha: 0.05)
                  : Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? AppColors.primary.withValues(alpha: 0.3)
                    : Colors.grey.withValues(alpha: 0.2),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: InkWell(
              onTap: () {
                context.read<PaymentPageBloc>().add(
                  PaymentPageEvent.toggleTransactionSelection(
                    transaction: latestTransaction,
                  ),
                );
              },
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _SelectionCheckbox(isSelected: isSelected),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _TransactionInfo(
                            transaction: latestTransaction,
                          ),
                        ),
                        _TransactionAmount(transaction: latestTransaction),
                      ],
                    ),
                    if (isSelected) ...[
                      const SizedBox(height: 16),
                      _buildQuickActionButtons(context, latestTransaction),
                      const SizedBox(height: 12),
                      _TransactionDetails(transaction: latestTransaction),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildQuickActionButtons(
    BuildContext context,
    PendingTransaction transaction,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.flash_on_rounded, size: 16, color: AppColors.primary),
          const SizedBox(width: 8),
          const Text(
            'Aksi Cepat:',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          const Spacer(),
          TextButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) =>
                    AddItemToTransactionDialog(transaction: transaction),
              );
            },
            icon: const Icon(Icons.edit_outlined, size: 16),
            label: const Text('Tambah Item'),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
                side: BorderSide(
                  color: AppColors.primary.withValues(alpha: 0.3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectionCheckbox extends StatelessWidget {
  final bool isSelected;

  const _SelectionCheckbox({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.transparent,
        border: Border.all(
          color: isSelected ? AppColors.primary : Colors.grey[400]!,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: isSelected
          ? const Icon(Icons.check, color: Colors.white, size: 16)
          : null,
    );
  }
}

class _TransactionInfo extends StatelessWidget {
  final PendingTransaction transaction;

  const _TransactionInfo({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final paymentPageBloc = context.read<PaymentPageBloc>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          transaction.orderNo,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(
              Icons.table_restaurant_rounded,
              size: 16,
              color: Colors.grey[600],
            ),
            const SizedBox(width: 4),
            Text(
              'Meja ${transaction.tableNo}',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            const SizedBox(width: 12),
            Icon(Icons.person_rounded, size: 16, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Text(
              transaction.customerName,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(
              Icons.access_time_rounded,
              size: 16,
              color: paymentPageBloc.isHighPriority(transaction.createdAt)
                  ? Colors.red[600]
                  : Colors.grey[600],
            ),
            const SizedBox(width: 4),
            Text(
              formatDateTime(transaction.createdAt.toString()),
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            const SizedBox(width: 8),
            _PriorityBadge(transaction: transaction),
          ],
        ),
      ],
    );
  }
}

class _PriorityBadge extends StatelessWidget {
  final PendingTransaction transaction;

  const _PriorityBadge({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final paymentPageBloc = context.read<PaymentPageBloc>();
    final isHighPriority = paymentPageBloc.isHighPriority(
      transaction.createdAt,
    );
    final waitingTime = paymentPageBloc.getWaitingTimeText(
      transaction.createdAt,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: isHighPriority
            ? Colors.red.withValues(alpha: 0.1)
            : Colors.blue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isHighPriority
              ? Colors.red.withValues(alpha: 0.3)
              : Colors.blue.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        isHighPriority ? 'PRIORITAS • $waitingTime' : 'TUNGGU • $waitingTime',
        style: TextStyle(
          color: isHighPriority ? Colors.red[700] : Colors.blue[700],
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _TransactionAmount extends StatelessWidget {
  final PendingTransaction transaction;

  const _TransactionAmount({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentPageBloc, PaymentPageState>(
      builder: (context, state) {
        final paymentPageBloc = context.read<PaymentPageBloc>();

        // Get the latest transaction data from state
        final latestTransaction =
            paymentPageBloc.getTransactionById(transaction.transactionId) ??
            transaction;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              idrFormat(latestTransaction.grandTotal),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
              ),
              child: Text(
                latestTransaction.status.toUpperCase(),
                style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TransactionDetails extends StatelessWidget {
  final PendingTransaction transaction;

  const _TransactionDetails({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentPageBloc, PaymentPageState>(
      builder: (context, state) {
        final paymentPageBloc = context.read<PaymentPageBloc>();

        // Get the latest transaction data from state
        final latestTransaction =
            paymentPageBloc.getTransactionById(transaction.transactionId) ??
            transaction;

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.receipt_long_rounded,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Detail Pesanan:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AddItemToTransactionDialog(
                          transaction: latestTransaction,
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit_outlined, size: 16),
                    label: const Text('Edit'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ...latestTransaction.details.map(
                (detail) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '${detail.quantity}x',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              detail.nameProduct,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                          Text(
                            idrFormat(detail.quantity * detail.price),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
