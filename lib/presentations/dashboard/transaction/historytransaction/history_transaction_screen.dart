import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/presentations/dashboard/transaction/historytransaction/bloc/history_transaction_bloc.dart';
import 'package:posmobile/presentations/dashboard/transaction/historytransaction/widgets/tabel_transaction.dart';
import 'package:posmobile/shared/widgets/top_bar.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class HistoryTransactionScreen extends StatefulWidget {
  const HistoryTransactionScreen({super.key});

  @override
  State<HistoryTransactionScreen> createState() =>
      _HistoryTransactionScreenState();
}

class _HistoryTransactionScreenState extends State<HistoryTransactionScreen> {
  TransactionTebelData? transactionDataSource;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<HistoryTransactionBloc>().add(
      HistoryTransactionEvent.fetchAllTransactions(),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
              TopBar(
                searchController: _searchController,
                onSearchChanged: (query) {
                  // TODO: Implement search functionality for transactions
                  // You can add search functionality here later
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transaction History',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'List of transactions made by the user',
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                      SizedBox(height: 16),
                      Expanded(
                        child:
                            BlocBuilder<
                              HistoryTransactionBloc,
                              HistoryTransactionState
                            >(
                              builder: (context, state) {
                                return state.when(
                                  initial: () => const Center(
                                    child: Text('Silakan tunggu...'),
                                  ),
                                  loading: () => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  failure: (message) => Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.error_outline,
                                          size: 64,
                                          color: Colors.red,
                                        ),
                                        SizedBox(height: 16),
                                        Text(
                                          'Error: $message',
                                          style: TextStyle(color: Colors.red),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 16),
                                        ElevatedButton(
                                          onPressed: () {
                                            context
                                                .read<HistoryTransactionBloc>()
                                                .add(
                                                  HistoryTransactionEvent.fetchAllTransactions(),
                                                );
                                          },
                                          child: Text('Coba Lagi'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  success: (transactionResponse) {
                                    // Inisialisasi transactionDataSource dengan data dari response
                                    transactionDataSource =
                                        TransactionTebelData(
                                          transactionResponse.data,
                                          context,
                                        );

                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: SfDataGrid(
                                        source: transactionDataSource!,
                                        columnWidthMode: ColumnWidthMode.fill,
                                        autoExpandGroups: true,
                                        gridLinesVisibility:
                                            GridLinesVisibility.none,
                                        headerGridLinesVisibility:
                                            GridLinesVisibility.both,
                                        rowHeight: 60,
                                        columns: [
                                          GridColumn(
                                            columnName: 'ID',
                                            columnWidthMode:
                                                ColumnWidthMode.fitByCellValue,
                                            label: Container(
                                              padding: EdgeInsets.all(12),
                                              alignment: Alignment.center,
                                              color: Colors.blueAccent,
                                              child: Text(
                                                'ID',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          GridColumn(
                                            columnName: 'Tanggal',
                                            columnWidthMode:
                                                ColumnWidthMode.fill,
                                            label: Container(
                                              padding: EdgeInsets.all(12),
                                              alignment: Alignment.center,
                                              color: Colors.blueAccent,
                                              child: Text(
                                                'Tanggal',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          GridColumn(
                                            columnName: 'Name',
                                            columnWidthMode:
                                                ColumnWidthMode.fitByCellValue,
                                            label: Container(
                                              padding: EdgeInsets.all(12),
                                              alignment: Alignment.center,
                                              color: Colors.blueAccent,
                                              child: Text(
                                                'Name',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          GridColumn(
                                            columnName: 'Total Harga',
                                            label: Container(
                                              padding: EdgeInsets.all(12),
                                              alignment: Alignment.center,
                                              color: Colors.blueAccent,
                                              child: Text(
                                                'Total Harga',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          GridColumn(
                                            columnName: 'Payment',
                                            label: Container(
                                              padding: EdgeInsets.all(12),
                                              alignment: Alignment.center,
                                              color: Colors.blueAccent,
                                              child: Text(
                                                'Payment',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          GridColumn(
                                            columnName: 'Detail',
                                            columnWidthMode:
                                                ColumnWidthMode.fitByColumnName,
                                            label: Container(
                                              padding: EdgeInsets.all(12),
                                              alignment: Alignment.center,
                                              color: Colors.blueAccent,
                                              child: Text(
                                                'Detail',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                      ),
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
