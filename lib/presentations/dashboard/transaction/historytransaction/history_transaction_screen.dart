import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/presentations/dashboard/transaction/historytransaction/bloc/history_transaction_bloc.dart';
import 'package:posmobile/presentations/dashboard/transaction/historytransaction/widgets/transaction_search_bar.dart';
import 'package:posmobile/presentations/dashboard/transaction/historytransaction/widgets/transaction_header.dart';
import 'package:posmobile/presentations/dashboard/transaction/historytransaction/widgets/transaction_content.dart';
import 'package:posmobile/shared/config/theme_extensions.dart';

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
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.only(bottom: context.spacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TransactionSearchBar(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(context.spacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TransactionHeader(),
                      SizedBox(height: context.spacing.md),
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
