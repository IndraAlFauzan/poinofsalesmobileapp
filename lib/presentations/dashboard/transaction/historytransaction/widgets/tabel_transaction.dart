import 'package:flutter/material.dart';
import 'package:posmobile/data/model/response/transaction_model.dart';
import 'package:posmobile/shared/widgets/idr_format.dart';
import 'package:posmobile/shared/config/app_colors.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TransactionTebelData extends DataGridSource {
  List<DataGridRow> _transactionData = [];
  final BuildContext context;
  final List<Transaction> transactions;
  static const int itemsPerPage = 15;
  int _currentPage = 1;

  TransactionTebelData(this.transactions, this.context) {
    _updateDataForCurrentPage();
  }

  // Getters for pagination
  int get currentPage => _currentPage;
  int get totalPages => (transactions.length / itemsPerPage).ceil();
  int get totalItems => transactions.length;
  bool get hasNextPage => _currentPage < totalPages;
  bool get hasPreviousPage => _currentPage > 1;

  // Getters for displaying range information
  int get startItem =>
      totalItems == 0 ? 0 : ((_currentPage - 1) * itemsPerPage) + 1;
  int get endItem {
    if (totalItems == 0) return 0;
    final calculatedEnd =
        (_currentPage - 1) * itemsPerPage + _transactionData.length;
    return calculatedEnd.clamp(1, totalItems);
  }

  void _updateDataForCurrentPage() {
    try {
      final startIndex = (_currentPage - 1) * itemsPerPage;
      final endIndex = (startIndex + itemsPerPage).clamp(
        0,
        transactions.length,
      );
      final currentPageTransactions = transactions.sublist(
        startIndex,
        endIndex,
      );

      _transactionData = currentPageTransactions
          .asMap()
          .entries
          .map<DataGridRow>((entry) {
            final transaction = entry.value;

            return DataGridRow(
              cells: [
                DataGridCell<String>(
                  columnName: 'Order ID',
                  value: transaction.orderNo,
                ),
                DataGridCell<String>(
                  columnName: 'Tanggal',
                  value: transaction.createdAt.toString(),
                ),
                DataGridCell<String>(
                  columnName: 'Person',
                  value: transaction.customerName.isEmpty
                      ? 'Unknown'
                      : transaction.customerName,
                ),
                DataGridCell<String>(
                  columnName: 'Total Harga',
                  value: idrFormat(transaction.grandTotal),
                ),
                DataGridCell<String>(
                  columnName: 'Status',
                  value: _getPaymentStatus(transaction.status),
                ),
                DataGridCell<String>(columnName: 'Detail', value: 'Detail'),
              ],
            );
          })
          .toList();
    } catch (e) {
      // Handle any errors during data processing
      _transactionData = [];
      debugPrint('Error updating transaction data: $e');
    }
  }

  // Methods for pagination
  void nextPage() {
    if (_currentPage < totalPages) {
      _currentPage++;
      _updateDataForCurrentPage();
      notifyListeners();
    }
  }

  void previousPage() {
    if (_currentPage > 1) {
      _currentPage--;
      _updateDataForCurrentPage();
      notifyListeners();
    }
  }

  void goToPage(int page) {
    if (page >= 1 && page <= totalPages) {
      _currentPage = page;
      _updateDataForCurrentPage();
      notifyListeners();
    }
  }

  @override
  List<DataGridRow> get rows => _transactionData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final rowIndex = _transactionData.indexOf(row);
    final isEvenRow = rowIndex % 2 == 0;

    return DataGridRowAdapter(
      color: isEvenRow ? Colors.white : const Color(0xFFFAFAFA),
      cells: row.getCells().asMap().entries.map<Widget>((entry) {
        final columnIndex = entry.key;
        final cell = entry.value;

        // special handling for ontap in detail column
        if (cell.columnName == 'Detail') {
          return Container(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                // Add safety check for rowIndex
                if (rowIndex >= 0 && rowIndex < transactions.length) {
                  final transaction = transactions[rowIndex];
                  _showTransactionDetail(context, transaction);
                }
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.accent,
                ),
                child: const Text(
                  'Detail',
                  style: TextStyle(
                    color: AppColors.textOnPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        }

        // Special handling for Status column to display badges
        if (cell.columnName == 'Status') {
          final status = cell.value.toString();
          final displayText = _getPaymentStatus(status);

          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: _getPaymentColor(status).withValues(alpha: 0.1),
                border: Border.all(color: _getPaymentColor(status), width: 1),
              ),
              child: Text(
                displayText,
                style: TextStyle(
                  color: _getPaymentColor(status),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          );
        }

        // Default cell rendering
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: cell.value is IconButton
              ? cell.value as IconButton
              : Text(
                  cell.value.toString(),
                  style: TextStyle(
                    fontWeight: columnIndex == 0
                        ? FontWeight.w600
                        : FontWeight.w500,
                    color: columnIndex == 0
                        ? AppColors.primary
                        : Colors.grey[800],
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
        );
      }).toList(),
    );
  }

  String _getPaymentStatus(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return 'Completed';
      case 'pending':
        return 'Pending';
      case 'cancelled':
        return 'Cancelled';
      default:
        return status
            .replaceAll('_', ' ')
            .split(' ')
            .map(
              (word) => word.isNotEmpty
                  ? word[0].toUpperCase() + word.substring(1).toLowerCase()
                  : '',
            )
            .join(' ');
    }
  }

  Color _getPaymentColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showTransactionDetail(BuildContext context, Transaction transaction) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Color(0xFFF8F9FA)],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header with gradient
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    gradient: LinearGradient(
                      colors: [AppColors.primary, Color(0xFF4A90E2)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.receipt_long,
                        color: Colors.white,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Transaction Detail',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
                // Content
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailItem('Order ID', transaction.orderNo),
                        _buildDetailItem(
                          'Date',
                          transaction.createdAt.toString(),
                        ),
                        _buildDetailItem('Customer', transaction.customerName),
                        _buildDetailItem('Table', transaction.tableNo ?? 'N/A'),
                        _buildDetailItem(
                          'Total Amount',
                          idrFormat(transaction.grandTotal),
                        ),
                        _buildDetailItem(
                          'Status',
                          _getPaymentStatus(transaction.status),
                        ),
                        _buildDetailItem(
                          'Service Type',
                          transaction.serviceType,
                        ),
                        const SizedBox(height: 24),
                        // Items section
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8F9FA),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.shopping_cart,
                                    color: AppColors.primary,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Order Items',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              ...transaction.details.map((detail) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.05,
                                        ),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              detail.productName,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                            ),
                                            if (detail.flavor != null)
                                              Text(
                                                'Flavor: ${detail.flavor}',
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 12,
                                                ),
                                              ),
                                            if (detail.spicyLevel != null)
                                              Text(
                                                'Spicy Level: ${detail.spicyLevel}',
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 12,
                                                ),
                                              ),
                                            if (detail.note != null &&
                                                detail.note!.isNotEmpty)
                                              Text(
                                                'Note: ${detail.note}',
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 12,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Qty: ${detail.quantity}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            idrFormat(
                                              detail.subtotal.toString(),
                                            ),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primary,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ),
          const Text(
            ': ',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
