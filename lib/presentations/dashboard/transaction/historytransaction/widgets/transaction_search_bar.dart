import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/presentations/dashboard/transaction/historytransaction/bloc/history_transaction_bloc.dart';
import 'package:posmobile/shared/widgets/top_bar.dart';

class TransactionSearchBar extends StatefulWidget {
  const TransactionSearchBar({super.key});

  @override
  State<TransactionSearchBar> createState() => _TransactionSearchBarState();
}

class _TransactionSearchBarState extends State<TransactionSearchBar> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TopBar(
      searchController: _searchController,
      hintText: "Cari transaksi, customer, produk...",
      onSearchChanged: (query) {
        context.read<HistoryTransactionBloc>().add(
          HistoryTransactionEvent.searchTransactions(query),
        );
      },
    );
  }
}
