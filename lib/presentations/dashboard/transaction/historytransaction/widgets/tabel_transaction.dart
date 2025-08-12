import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posmobile/data/model/response/transaction_mode_response.dart';
import 'package:posmobile/shared/widgets/fortmat_datetime.dart';
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
    final startIndex = (_currentPage - 1) * itemsPerPage;
    final endIndex = (startIndex + itemsPerPage).clamp(0, transactions.length);
    final currentPageTransactions = transactions.sublist(startIndex, endIndex);

    _transactionData = currentPageTransactions.asMap().entries.map<DataGridRow>(
      (entry) {
        final transaction = entry.value;

        return DataGridRow(
          cells: [
            DataGridCell<String>(
              columnName: 'Order ID',
              value: '#${transaction.transactionId}',
            ),
            DataGridCell<String>(
              columnName: 'Tanggal',
              value: formatDateTime(transaction.createdAt.toIso8601String()),
            ),
            DataGridCell<String>(
              columnName: 'Person',
              value: transaction.nameUser,
            ),
            DataGridCell<String>(
              columnName: 'Total Harga',
              value: idrFormat(transaction.total.toString()),
            ),
            DataGridCell<String>(
              columnName: 'Payment',
              value: transaction.paymentMethod,
            ),
            DataGridCell<String>(columnName: 'Detail', value: 'Detail'),
          ],
        );
      },
    ).toList();
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
                final transaction = transactions[rowIndex];
                _showTransactionDetail(context, transaction);
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

        // Special handling for Payment column to display badges
        if (cell.columnName == 'Payment') {
          final paymentMethod = cell.value.toString();
          final displayText = _formatPaymentMethod(paymentMethod);

          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: _getPaymentColor(displayText).withOpacity(0.1),
                border: Border.all(
                  color: _getPaymentColor(displayText),
                  width: 1,
                ),
              ),
              child: Text(
                displayText,
                style: TextStyle(
                  color: _getPaymentColor(displayText),
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

  String _formatPaymentMethod(String paymentMethod) {
    switch (paymentMethod.toLowerCase()) {
      case 'cash':
        return 'Cash';
      case 'qris':
        return 'QRIS';
      case 'credit_card':
        return 'Credit Card';
      case 'debit_card':
        return 'Debit Card';
      case 'transfer':
        return 'Transfer';
      default:
        return paymentMethod
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

  Color _getPaymentColor(String paymentMethod) {
    switch (paymentMethod.toLowerCase()) {
      case 'cash':
        return Colors.green;
      case 'qris':
        return Colors.blue;
      case 'credit card':
        return Colors.purple;
      case 'debit card':
        return Colors.orange;
      case 'transfer':
        return Colors.teal;
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
                        _buildDetailItem(
                          'Order ID',
                          '#${transaction.transactionId}',
                        ),
                        _buildDetailItem(
                          'Date',
                          formatDateTime(
                            transaction.createdAt.toIso8601String(),
                          ),
                        ),
                        _buildDetailItem('Customer', transaction.nameUser),
                        _buildDetailItem(
                          'Total Amount',
                          idrFormat(transaction.total.toString()),
                        ),
                        _buildDetailItem(
                          'Payment Method',
                          _formatPaymentMethod(transaction.paymentMethod),
                        ),
                        _buildDetailItem('Status', 'Completed'),
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
                                        color: Colors.black.withOpacity(0.05),
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
                                              detail.nameProduct,
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
                              }).toList(),
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
            color: Colors.black.withOpacity(0.02),
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
