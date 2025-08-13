import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/presentations/dashboard/transaction/historytransaction/bloc/history_transaction_bloc.dart';
import 'package:posmobile/presentations/dashboard/transaction/historytransaction/widgets/tabel_transaction.dart';
import 'package:posmobile/presentations/dashboard/transaction/historytransaction/widgets/pagination_controls.dart';
import 'package:posmobile/shared/widgets/top_bar.dart';
import 'package:posmobile/shared/config/app_colors.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class HistoryTransactionScreen extends StatefulWidget {
  const HistoryTransactionScreen({super.key});

  @override
  State<HistoryTransactionScreen> createState() =>
      _HistoryTransactionScreenState();
}

class _HistoryTransactionScreenState extends State<HistoryTransactionScreen>
    with TickerProviderStateMixin {
  TransactionTebelData? transactionDataSource;
  final _searchController = TextEditingController();
  AnimationController? _refreshAnimationController;
  Animation<double>? _refreshAnimation;
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();

    // Initialize refresh animation
    _refreshAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _refreshAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _refreshAnimationController!,
        curve: Curves.easeInOut,
      ),
    );

    context.read<HistoryTransactionBloc>().add(
      HistoryTransactionEvent.fetchAllTransactions(),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _refreshAnimationController?.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    if (_isRefreshing || _refreshAnimationController == null) return;

    setState(() {
      _isRefreshing = true;
    });

    _refreshAnimationController!.repeat();

    // Add a small delay for better UX
    await Future.delayed(const Duration(milliseconds: 300));

    context.read<HistoryTransactionBloc>().add(
      HistoryTransactionEvent.fetchAllTransactions(),
    );
  }

  void _stopRefreshAnimation() {
    if (_isRefreshing && _refreshAnimationController != null) {
      _refreshAnimationController!.stop();
      _refreshAnimationController!.reset();
      setState(() {
        _isRefreshing = false;
      });
    }
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
                hintText: "Cari transaksi, customer, produk...",
                onSearchChanged: (query) {
                  context.read<HistoryTransactionBloc>().add(
                    HistoryTransactionEvent.searchTransactions(query),
                  );
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Transaction History\n',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors
                                        .black, // Wajib set color di TextSpan
                                  ),
                                ),
                                TextSpan(
                                  text: 'List of transactions made by the user',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: _handleRefresh,
                            borderRadius: BorderRadius.circular(8),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: _isRefreshing
                                    ? AppColors.primary
                                    : AppColors.primary,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: _isRefreshing
                                    ? [
                                        BoxShadow(
                                          color: AppColors.primary.withValues(
                                            alpha: 0.3,
                                          ),
                                          blurRadius: 8,
                                          spreadRadius: 2,
                                        ),
                                      ]
                                    : null,
                              ),
                              child: Row(
                                children: [
                                  _refreshAnimationController != null
                                      ? AnimatedBuilder(
                                          animation:
                                              _refreshAnimationController!,
                                          builder: (context, child) {
                                            return Transform.rotate(
                                              angle:
                                                  _refreshAnimationController!
                                                      .value *
                                                  2 *
                                                  3.14159,
                                              child: Icon(
                                                Icons.refresh,
                                                color: AppColors.textOnPrimary,
                                                size: 20,
                                              ),
                                            );
                                          },
                                        )
                                      : Icon(
                                          Icons.refresh,
                                          color: AppColors.textOnPrimary,
                                          size: 20,
                                        ),
                                  const SizedBox(width: 8),
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 200),
                                    child: Text(
                                      _isRefreshing
                                          ? "Refreshing..."
                                          : "Refresh",
                                      key: ValueKey(
                                        'refresh_text_$_isRefreshing',
                                      ),
                                      style: TextStyle(
                                        color: AppColors.textOnPrimary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Expanded(
                        child: BlocConsumer<HistoryTransactionBloc, HistoryTransactionState>(
                          listener: (context, state) {
                            // Stop refresh animation when data is loaded or failed
                            state.whenOrNull(
                              success: (_) => _stopRefreshAnimation(),
                              failure: (_) => _stopRefreshAnimation(),
                            );
                          },
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
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                        context.read<HistoryTransactionBloc>().add(
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
                                transactionDataSource = TransactionTebelData(
                                  transactionResponse.data,
                                  context,
                                );

                                return Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withValues(
                                                alpha: 0.05,
                                              ),
                                              blurRadius: 10,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: AnimatedSwitcher(
                                          duration: const Duration(
                                            milliseconds: 400,
                                          ),
                                          switchInCurve: Curves.easeOutCubic,
                                          switchOutCurve: Curves.easeInCubic,
                                          transitionBuilder:
                                              (
                                                Widget child,
                                                Animation<double> animation,
                                              ) {
                                                return FadeTransition(
                                                  opacity: animation,
                                                  child: SlideTransition(
                                                    position:
                                                        Tween<Offset>(
                                                          begin: const Offset(
                                                            0.0,
                                                            0.1,
                                                          ),
                                                          end: Offset.zero,
                                                        ).animate(
                                                          CurvedAnimation(
                                                            parent: animation,
                                                            curve: Curves
                                                                .easeOutCubic,
                                                          ),
                                                        ),
                                                    child: child,
                                                  ),
                                                );
                                              },
                                          child: ClipRRect(
                                            key: ValueKey(
                                              'data_grid_${transactionResponse.data.length}_${DateTime.now().millisecondsSinceEpoch}',
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            child: AnimatedBuilder(
                                              animation: transactionDataSource!,
                                              builder: (context, child) {
                                                return SfDataGrid(
                                                  source:
                                                      transactionDataSource!,
                                                  columnWidthMode:
                                                      ColumnWidthMode.fill,
                                                  autoExpandGroups: true,
                                                  gridLinesVisibility:
                                                      GridLinesVisibility.none,
                                                  headerGridLinesVisibility:
                                                      GridLinesVisibility.none,
                                                  rowHeight: 65,
                                                  headerRowHeight: 55,
                                                  columns: [
                                                    GridColumn(
                                                      columnName: 'Order ID',
                                                      columnWidthMode:
                                                          ColumnWidthMode
                                                              .fitByColumnName,
                                                      label: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                              gradient: LinearGradient(
                                                                colors: [
                                                                  AppColors
                                                                      .primary,
                                                                  Color(
                                                                    0xFF4A90E2,
                                                                  ),
                                                                ],
                                                                begin: Alignment
                                                                    .topLeft,
                                                                end: Alignment
                                                                    .bottomRight,
                                                              ),
                                                            ),
                                                        alignment:
                                                            Alignment.center,
                                                        child: const Text(
                                                          'Order ID',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    GridColumn(
                                                      columnName: 'Tanggal',
                                                      columnWidthMode:
                                                          ColumnWidthMode.fill,
                                                      label: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                              gradient: LinearGradient(
                                                                colors: [
                                                                  AppColors
                                                                      .primary,
                                                                  Color(
                                                                    0xFF4A90E2,
                                                                  ),
                                                                ],
                                                                begin: Alignment
                                                                    .topLeft,
                                                                end: Alignment
                                                                    .bottomRight,
                                                              ),
                                                            ),
                                                        alignment:
                                                            Alignment.center,
                                                        child: const Text(
                                                          'Tanggal',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    GridColumn(
                                                      columnName: 'Person',
                                                      columnWidthMode:
                                                          ColumnWidthMode
                                                              .fitByColumnName,
                                                      label: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                              gradient: LinearGradient(
                                                                colors: [
                                                                  AppColors
                                                                      .primary,
                                                                  Color(
                                                                    0xFF4A90E2,
                                                                  ),
                                                                ],
                                                                begin: Alignment
                                                                    .topLeft,
                                                                end: Alignment
                                                                    .bottomRight,
                                                              ),
                                                            ),
                                                        alignment:
                                                            Alignment.center,
                                                        child: const Text(
                                                          'Kasir',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    GridColumn(
                                                      columnName: 'Total Harga',
                                                      columnWidthMode:
                                                          ColumnWidthMode.fill,
                                                      label: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                              gradient: LinearGradient(
                                                                colors: [
                                                                  AppColors
                                                                      .primary,
                                                                  Color(
                                                                    0xFF4A90E2,
                                                                  ),
                                                                ],
                                                                begin: Alignment
                                                                    .topLeft,
                                                                end: Alignment
                                                                    .bottomRight,
                                                              ),
                                                            ),
                                                        alignment:
                                                            Alignment.center,
                                                        child: const Text(
                                                          'Total',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    GridColumn(
                                                      columnName: 'Payment',
                                                      columnWidthMode:
                                                          ColumnWidthMode.fill,
                                                      label: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                              gradient: LinearGradient(
                                                                colors: [
                                                                  AppColors
                                                                      .primary,
                                                                  Color(
                                                                    0xFF4A90E2,
                                                                  ),
                                                                ],
                                                                begin: Alignment
                                                                    .topLeft,
                                                                end: Alignment
                                                                    .bottomRight,
                                                              ),
                                                            ),
                                                        alignment:
                                                            Alignment.center,
                                                        child: const Text(
                                                          'Payment',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    GridColumn(
                                                      columnName: 'Detail',
                                                      columnWidthMode:
                                                          ColumnWidthMode.none,
                                                      label: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                              gradient: LinearGradient(
                                                                colors: [
                                                                  AppColors
                                                                      .primary,
                                                                  Color(
                                                                    0xFF4A90E2,
                                                                  ),
                                                                ],
                                                                begin: Alignment
                                                                    .topLeft,
                                                                end: Alignment
                                                                    .bottomRight,
                                                              ),
                                                            ),
                                                        alignment:
                                                            Alignment.center,
                                                        child: const Text(
                                                          'Action',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Pagination Controls
                                    PaginationControls(
                                      dataSource: transactionDataSource!,
                                    ),
                                  ],
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
