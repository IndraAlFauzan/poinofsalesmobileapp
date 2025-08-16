import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/presentations/dashboard/transaction/historytransaction/bloc/history_transaction_bloc.dart';
import 'package:posmobile/presentations/dashboard/transaction/historytransaction/widgets/transaction_search_bar.dart';
import 'package:posmobile/presentations/dashboard/transaction/historytransaction/widgets/transaction_header.dart';
import 'package:posmobile/presentations/dashboard/transaction/historytransaction/widgets/transaction_content.dart';

class HistoryTransactionScreen extends StatefulWidget {
  const HistoryTransactionScreen({super.key});

  @override
  State<HistoryTransactionScreen> createState() =>
      _HistoryTransactionScreenState();
}

class _HistoryTransactionScreenState extends State<HistoryTransactionScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HistoryTransactionBloc>().add(
      const HistoryTransactionEvent.fetchAllTransactions(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TransactionSearchBar(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TransactionHeader(),
                      const SizedBox(height: 16),
                      const Expanded(child: TransactionContent()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
