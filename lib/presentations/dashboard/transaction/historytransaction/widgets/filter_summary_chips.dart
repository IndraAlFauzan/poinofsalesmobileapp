import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:posmobile/presentations/dashboard/transaction/historytransaction/bloc/history_transaction_bloc.dart';
import 'package:posmobile/shared/config/app_colors.dart';

class FilterSummaryChips extends StatelessWidget {
  final TransactionFilter filter;
  final VoidCallback onClearAll;

  const FilterSummaryChips({
    super.key,
    required this.filter,
    required this.onClearAll,
  });

  @override
  Widget build(BuildContext context) {
    final chips = <Widget>[];

    // Status chip
    if (filter.status != null) {
      chips.add(_buildChip('Status: ${filter.status}'));
    }

    // Date range chip
    if (filter.startDate != null || filter.endDate != null) {
      String dateText = 'Date: ';
      if (filter.startDate != null && filter.endDate != null) {
        dateText +=
            '${DateFormat('dd/MM/yy').format(filter.startDate!)} - ${DateFormat('dd/MM/yy').format(filter.endDate!)}';
      } else if (filter.startDate != null) {
        dateText += 'From ${DateFormat('dd/MM/yy').format(filter.startDate!)}';
      } else {
        dateText += 'Until ${DateFormat('dd/MM/yy').format(filter.endDate!)}';
      }
      chips.add(_buildChip(dateText));
    }

    // Customer chip
    if (filter.customerName != null && filter.customerName!.isNotEmpty) {
      chips.add(_buildChip('Customer: ${filter.customerName}'));
    }

    // Amount range chip
    if (filter.minAmount != null || filter.maxAmount != null) {
      String amountText = 'Amount: ';
      if (filter.minAmount != null && filter.maxAmount != null) {
        amountText +=
            'Rp ${_formatAmount(filter.minAmount!)} - Rp ${_formatAmount(filter.maxAmount!)}';
      } else if (filter.minAmount != null) {
        amountText += '≥ Rp ${_formatAmount(filter.minAmount!)}';
      } else {
        amountText += '≤ Rp ${_formatAmount(filter.maxAmount!)}';
      }
      chips.add(_buildChip(amountText));
    }

    if (chips.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: [
        ...chips,
        GestureDetector(
          onTap: onClearAll,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.red.shade300),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.clear_all, size: 14, color: Colors.red.shade600),
                const SizedBox(width: 4),
                Text(
                  'Clear All',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  String _formatAmount(double amount) {
    return NumberFormat('#,###').format(amount);
  }
}
