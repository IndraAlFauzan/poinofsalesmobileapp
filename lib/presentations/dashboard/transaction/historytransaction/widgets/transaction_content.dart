import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/presentations/dashboard/transaction/historytransaction/bloc/history_transaction_bloc.dart';
import 'package:posmobile/presentations/dashboard/transaction/historytransaction/widgets/transaction_data_grid.dart';
import 'package:posmobile/presentations/dashboard/transaction/historytransaction/widgets/transaction_state_widgets.dart';

class TransactionContent extends StatelessWidget {
  const TransactionContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryTransactionBloc, HistoryTransactionState>(
      builder: (context, state) {
        return state.when(
          initial: () => TransactionStateWidgets.buildInitialState(),
          loading: () => TransactionStateWidgets.buildLoadingState(),
          refreshing: () => TransactionStateWidgets.buildRefreshingState(),
          failure: (message) =>
              TransactionStateWidgets.buildErrorState(message),
          success: (transactionResponse) {
            if (transactionResponse.data.isEmpty) {
              return TransactionStateWidgets.buildEmptyState();
            }
            return TransactionDataGrid(
              transactionResponse: transactionResponse,
            );
          },
        );
      },
    );
  }
}
