import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/presentations/dashboard/transaction/historytransaction/bloc/history_transaction_bloc.dart';
import 'package:posmobile/presentations/dashboard/transaction/historytransaction/widgets/filter_summary_chips.dart';
import 'package:posmobile/shared/config/app_colors.dart';

class ActiveFiltersIndicator extends StatelessWidget {
  const ActiveFiltersIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryTransactionBloc, HistoryTransactionState>(
      builder: (context, state) {
        final bloc = context.read<HistoryTransactionBloc>();
        final filter = bloc.currentFilter;

        if (!_hasActiveFilters(bloc)) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.filter_alt, size: 16, color: AppColors.primary),
                const SizedBox(width: 4),
                Text(
                  'Active Filters:',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            FilterSummaryChips(
              filter: filter!,
              onClearAll: () {
                context.read<HistoryTransactionBloc>().add(
                  const HistoryTransactionEvent.clearFilters(),
                );
              },
            ),
          ],
        );
      },
    );
  }

  bool _hasActiveFilters(HistoryTransactionBloc bloc) {
    final filter = bloc.currentFilter;
    if (filter == null) return false;

    return filter.status != null ||
        filter.startDate != null ||
        filter.endDate != null ||
        (filter.customerName != null && filter.customerName!.isNotEmpty) ||
        filter.minAmount != null ||
        filter.maxAmount != null;
  }
}
