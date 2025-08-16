import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/presentations/dashboard/transaction/historytransaction/bloc/history_transaction_bloc.dart';
import 'package:posmobile/shared/config/app_colors.dart';

class SimpleFilterChips extends StatelessWidget {
  const SimpleFilterChips({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryTransactionBloc, HistoryTransactionState>(
      builder: (context, state) {
        final bloc = context.read<HistoryTransactionBloc>();
        final currentFilter = bloc.currentFilter;

        return Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            _buildFilterChip(
              context,
              'All',
              currentFilter == null,
              () => _clearFilters(context),
            ),

            _buildFilterChip(
              context,
              'Pending',
              currentFilter?.status == 'pending',
              () => _applyStatusFilter(context, 'pending'),
            ),
            _buildFilterChip(
              context,
              'Today',
              _isToday(currentFilter),
              () => _applyTodayFilter(context),
            ),
            _buildFilterChip(
              context,
              'This Week',
              _isThisWeek(currentFilter),
              () => _applyDateFilter(
                context,
                DateTime.now().subtract(const Duration(days: 7)),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    String label,
    bool isActive,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isActive ? AppColors.primary : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? Colors.white : Colors.grey.shade700,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  void _clearFilters(BuildContext context) {
    context.read<HistoryTransactionBloc>().add(
      const HistoryTransactionEvent.clearFilters(),
    );
  }

  void _applyStatusFilter(BuildContext context, String status) {
    final filter = TransactionFilter(status: status);
    context.read<HistoryTransactionBloc>().add(
      HistoryTransactionEvent.filterTransactions(filter),
    );
  }

  void _applyDateFilter(BuildContext context, DateTime startDate) {
    final filter = TransactionFilter(
      startDate: startDate,
      endDate: DateTime.now(),
    );
    context.read<HistoryTransactionBloc>().add(
      HistoryTransactionEvent.filterTransactions(filter),
    );
  }

  void _applyTodayFilter(BuildContext context) {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = DateTime(today.year, today.month, today.day, 23, 59, 59);

    final filter = TransactionFilter(startDate: startOfDay, endDate: endOfDay);
    context.read<HistoryTransactionBloc>().add(
      HistoryTransactionEvent.filterTransactions(filter),
    );
  }

  bool _isToday(TransactionFilter? filter) {
    if (filter?.startDate == null) return false;
    final today = DateTime.now();
    final filterDate = filter!.startDate!;
    return filterDate.year == today.year &&
        filterDate.month == today.month &&
        filterDate.day == today.day;
  }

  bool _isThisWeek(TransactionFilter? filter) {
    if (filter?.startDate == null) return false;
    final weekAgo = DateTime.now().subtract(const Duration(days: 7));
    final filterDate = filter!.startDate!;
    // Simple check: if filter date is roughly a week ago
    return filterDate.difference(weekAgo).inDays.abs() <= 1;
  }
}
