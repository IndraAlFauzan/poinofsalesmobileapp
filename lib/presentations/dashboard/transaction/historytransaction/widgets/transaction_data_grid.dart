import 'package:flutter/material.dart';
import 'package:posmobile/data/model/response/transaction_model.dart';
import 'package:posmobile/presentations/dashboard/transaction/historytransaction/widgets/tabel_transaction.dart';
import 'package:posmobile/presentations/dashboard/transaction/historytransaction/widgets/pagination_controls.dart';
import 'package:posmobile/shared/config/app_colors.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TransactionDataGrid extends StatelessWidget {
  final AllTransactionModelResponse transactionResponse;

  const TransactionDataGrid({super.key, required this.transactionResponse});

  @override
  Widget build(BuildContext context) {
    final transactionDataSource = TransactionTebelData(
      transactionResponse.data,
      context,
    );

    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position:
                        Tween<Offset>(
                          begin: const Offset(0.0, 0.1),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOutCubic,
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
                borderRadius: BorderRadius.circular(12),
                child: AnimatedBuilder(
                  animation: transactionDataSource,
                  builder: (context, child) {
                    return SfDataGrid(
                      source: transactionDataSource,
                      columnWidthMode: ColumnWidthMode.fill,
                      autoExpandGroups: true,
                      gridLinesVisibility: GridLinesVisibility.none,
                      headerGridLinesVisibility: GridLinesVisibility.none,
                      rowHeight: 65,
                      headerRowHeight: 55,
                      columns: _buildGridColumns(),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        // Pagination Controls
        PaginationControls(dataSource: transactionDataSource),
      ],
    );
  }

  List<GridColumn> _buildGridColumns() {
    return [
      _buildGridColumn('Order ID', 'Order ID', ColumnWidthMode.fitByCellValue),
      _buildGridColumn('Tanggal', 'Tanggal', ColumnWidthMode.fill),
      _buildGridColumn('Person', 'Customer', ColumnWidthMode.fitByColumnName),
      _buildGridColumn('Total Harga', 'Total', ColumnWidthMode.fill),
      _buildGridColumn('Status', 'Status', ColumnWidthMode.fill),
      _buildGridColumn('Detail', 'Action', ColumnWidthMode.none),
    ];
  }

  GridColumn _buildGridColumn(
    String columnName,
    String labelText,
    ColumnWidthMode widthMode,
  ) {
    return GridColumn(
      columnName: columnName,
      columnWidthMode: widthMode,
      label: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, Color(0xFF4A90E2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          labelText,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
