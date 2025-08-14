import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/bloc/pending_transaction/pending_transaction_bloc.dart';
import 'package:posmobile/bloc/payment_settlement/payment_settlement_bloc.dart';
import 'package:posmobile/bloc/payment_method/payment_method_bloc.dart';
import 'package:posmobile/data/model/response/pending_transactions_response.dart';
import 'package:posmobile/data/model/request/payment_settle_request.dart';
import 'package:posmobile/shared/widgets/idr_format.dart';
import 'package:posmobile/shared/widgets/fortmat_datetime.dart';
import 'package:posmobile/shared/config/app_colors.dart';
import 'package:posmobile/presentations/dashboard/payment/paymentpage/widgets/payment_success_dialog.dart';
import 'package:posmobile/shared/widgets/top_bar.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final List<PendingTransaction> _selectedTransactions = [];
  int? _selectedPaymentMethodId;
  final _tenderedAmountController = TextEditingController();
  final _noteController = TextEditingController();
  String? _selectedTableNo;
  List<PendingTransaction> _allTransactions = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PendingTransactionBloc>().add(
        const PendingTransactionEvent.fetchPendingTransactions(),
      );
      context.read<PaymentMethodBloc>().add(
        const PaymentMethodEvent.fetchPaymentMethods(),
      );
    });
  }

  @override
  void dispose() {
    _tenderedAmountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  double get totalAmount {
    return _selectedTransactions.fold(
      0.0,
      (sum, transaction) => sum + double.parse(transaction.grandTotal),
    );
  }

  // Get unique table numbers from transactions
  List<String> get availableTableNumbers {
    final tables = _allTransactions.map((t) => t.tableNo).toSet().toList();
    tables.sort(
      (a, b) =>
          int.tryParse(a)?.compareTo(int.tryParse(b) ?? 0) ?? a.compareTo(b),
    );
    return tables;
  }

  // Get filtered and sorted transactions
  List<PendingTransaction> get filteredTransactions {
    var filtered = _allTransactions;

    // Filter by selected table if any
    if (_selectedTableNo != null) {
      filtered = filtered.where((t) => t.tableNo == _selectedTableNo).toList();
    }

    // Sort by creation time (oldest first)
    filtered.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    return filtered;
  }

  // Helper method to calculate waiting time and priority
  String _getWaitingTimeText(DateTime createdAt) {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inHours > 0) {
      return '${difference.inHours}j ${difference.inMinutes % 60}m';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'Baru saja';
    }
  }

  bool _isHighPriority(DateTime createdAt) {
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    return difference.inMinutes >
        30; // High priority if waiting more than 30 minutes
  }

  void _toggleTransactionSelection(PendingTransaction transaction) {
    setState(() {
      if (_selectedTransactions.contains(transaction)) {
        _selectedTransactions.remove(transaction);
      } else {
        _selectedTransactions.add(transaction);
      }
    });
  }

  void _processPayment() {
    if (_selectedTransactions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih pesanan yang akan dibayar')),
      );
      return;
    }

    if (_selectedPaymentMethodId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Pilih metode pembayaran')));
      return;
    }

    // For cash payment, validate tendered amount
    if (_selectedPaymentMethodId == 1) {
      final tenderedAmount = double.tryParse(_tenderedAmountController.text);
      if (tenderedAmount == null || tenderedAmount < totalAmount) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Jumlah uang tidak valid')),
        );
        return;
      }
    }

    final request = PaymentSettleRequest(
      paymentMethodId: _selectedPaymentMethodId!,
      transactionIds: _selectedTransactions
          .map((t) => t.transactionId)
          .toList(),
      tenderedAmount: _selectedPaymentMethodId == 1
          ? double.tryParse(_tenderedAmountController.text)
          : null,
      note: _noteController.text.isEmpty ? null : _noteController.text,
    );

    context.read<PaymentSettlementBloc>().add(
      PaymentSettlementEvent.settlePayment(request: request),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.blueGrey[50],
        body: MultiBlocListener(
          listeners: [
            BlocListener<PaymentSettlementBloc, PaymentSettlementState>(
              listener: (context, state) {
                state.whenOrNull(
                  paymentSettled: (response) {
                    // Store selected transactions and payment data for receipt
                    final paidTransactions = List<PendingTransaction>.from(
                      _selectedTransactions,
                    );
                    final currentTotalAmount = totalAmount;
                    final currentPaymentMethod = _selectedPaymentMethodId == 1
                        ? 'Cash'
                        : 'Non-Cash';
                    final currentTenderedAmount = _selectedPaymentMethodId == 1
                        ? double.tryParse(_tenderedAmountController.text)
                        : null;
                    final currentChangeAmount = currentTenderedAmount != null
                        ? (currentTenderedAmount - currentTotalAmount).clamp(
                            0.0,
                            double.infinity,
                          )
                        : null;

                    // Clear selections
                    setState(() {
                      _selectedTransactions.clear();
                      _selectedPaymentMethodId = null;
                      _selectedTableNo = null;
                      _tenderedAmountController.clear();
                      _noteController.clear();
                    });

                    // Refresh pending transactions
                    context.read<PendingTransactionBloc>().add(
                      const PendingTransactionEvent.fetchPendingTransactions(),
                    );

                    // Add debug print
                    print(
                      'DEBUG: Refreshing pending transactions after payment',
                    );

                    // Show success dialog
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => PaymentSuccessDialog(
                        paymentId: response.data.paymentId,
                        paidTransactions: paidTransactions,
                        totalAmount: currentTotalAmount,
                        paymentMethod: currentPaymentMethod,
                        tenderedAmount: currentTenderedAmount,
                        changeAmount: currentChangeAmount,
                      ),
                    );
                  },
                  failure: (message) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 8),
                            Expanded(child: Text('Error: $message')),
                          ],
                        ),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                    print(
                      'DEBUG: Payment settlement failed with message: $message',
                    );
                  },
                );
              },
            ),
          ],
          child: Column(
            children: [
              TopBar(hintText: 'Cari Pesanan...'),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left side - Pending transactions list
                      Expanded(flex: 2, child: _buildPendingTransactionsList()),
                      const SizedBox(width: 16),

                      // Right side - Payment form
                      Expanded(flex: 1, child: _buildPaymentForm()),
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

  Widget _buildPendingTransactionsList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.pending_actions_rounded,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Pesanan Pending',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    context.read<PendingTransactionBloc>().add(
                      const PendingTransactionEvent.fetchPendingTransactions(),
                    );
                  },
                  icon: Icon(Icons.refresh_rounded, color: AppColors.primary),
                  tooltip: 'Refresh Data',
                ),
              ],
            ),

            // Table filter dropdown
            if (_allTransactions.isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.2),
                  ),
                ),
                child: DropdownButtonFormField<String>(
                  value: _selectedTableNo,
                  decoration: InputDecoration(
                    labelText: 'Filter No. Meja',
                    prefixIcon: Icon(
                      Icons.table_restaurant_rounded,
                      color: AppColors.primary,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                    labelStyle: TextStyle(color: AppColors.primary),
                  ),
                  hint: const Text('Semua Meja'),
                  items: [
                    const DropdownMenuItem<String>(
                      value: null,
                      child: Text('Semua Meja'),
                    ),
                    ...availableTableNumbers.map(
                      (tableNo) => DropdownMenuItem<String>(
                        value: tableNo,
                        child: Row(
                          children: [
                            Icon(
                              Icons.table_restaurant_rounded,
                              size: 16,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 8),
                            Text('Meja $tableNo'),
                          ],
                        ),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedTableNo = value;
                      _selectedTransactions
                          .clear(); // Clear selections when changing filter
                    });
                  },
                ),
              ),
              const SizedBox(height: 8),
              // Show transaction count for selected table
              Row(
                children: [
                  Icon(Icons.info_outline, size: 16, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Text(
                    _selectedTableNo != null
                        ? 'Menampilkan ${filteredTransactions.length} pesanan untuk Meja $_selectedTableNo'
                        : 'Menampilkan ${filteredTransactions.length} pesanan dari ${availableTableNumbers.length} meja',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<PendingTransactionBloc, PendingTransactionState>(
                builder: (context, state) {
                  return state.when(
                    initial: () =>
                        _buildEmptyState('Belum ada pesanan pending'),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    success: (transactions) {
                      // Store all transactions for filtering - create mutable copy
                      _allTransactions = List<PendingTransaction>.from(
                        transactions,
                      );

                      final displayTransactions = filteredTransactions;

                      if (displayTransactions.isEmpty) {
                        return _selectedTableNo != null
                            ? _buildEmptyState(
                                'Tidak ada pesanan di Meja $_selectedTableNo',
                              )
                            : _buildEmptyState('Belum ada pesanan pending');
                      }
                      return ListView.builder(
                        itemCount: displayTransactions.length,
                        itemBuilder: (context, index) {
                          final transaction = displayTransactions[index];
                          final isSelected = _selectedTransactions.contains(
                            transaction,
                          );

                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary.withValues(alpha: 0.05)
                                  : Colors.grey[50],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary.withValues(alpha: 0.3)
                                    : Colors.grey.withValues(alpha: 0.2),
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            child: InkWell(
                              onTap: () =>
                                  _toggleTransactionSelection(transaction),
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? AppColors.primary
                                                : Colors.transparent,
                                            border: Border.all(
                                              color: isSelected
                                                  ? AppColors.primary
                                                  : Colors.grey[400]!,
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),
                                          child: isSelected
                                              ? const Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                  size: 16,
                                                )
                                              : null,
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                transaction.orderNo,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .table_restaurant_rounded,
                                                    size: 16,
                                                    color: Colors.grey[600],
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    'Meja ${transaction.tableNo}',
                                                    style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 12),
                                                  Icon(
                                                    Icons.person_rounded,
                                                    size: 16,
                                                    color: Colors.grey[600],
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    transaction.customerName,
                                                    style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.access_time_rounded,
                                                    size: 16,
                                                    color:
                                                        _isHighPriority(
                                                          transaction.createdAt,
                                                        )
                                                        ? Colors.red[600]
                                                        : Colors.grey[600],
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    formatDateTime(
                                                      transaction.createdAt
                                                          .toString(),
                                                    ),
                                                    style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 6,
                                                          vertical: 2,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          _isHighPriority(
                                                            transaction
                                                                .createdAt,
                                                          )
                                                          ? Colors.red
                                                                .withValues(
                                                                  alpha: 0.1,
                                                                )
                                                          : Colors.blue
                                                                .withValues(
                                                                  alpha: 0.1,
                                                                ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8,
                                                          ),
                                                      border: Border.all(
                                                        color:
                                                            _isHighPriority(
                                                              transaction
                                                                  .createdAt,
                                                            )
                                                            ? Colors.red
                                                                  .withValues(
                                                                    alpha: 0.3,
                                                                  )
                                                            : Colors.blue
                                                                  .withValues(
                                                                    alpha: 0.3,
                                                                  ),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      _isHighPriority(
                                                            transaction
                                                                .createdAt,
                                                          )
                                                          ? 'PRIORITAS • ${_getWaitingTimeText(transaction.createdAt)}'
                                                          : 'TUNGGU • ${_getWaitingTimeText(transaction.createdAt)}',
                                                      style: TextStyle(
                                                        color:
                                                            _isHighPriority(
                                                              transaction
                                                                  .createdAt,
                                                            )
                                                            ? Colors.red[700]
                                                            : Colors.blue[700],
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              idrFormat(transaction.grandTotal),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: AppColors.primary,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 6,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: Colors.orange.withValues(
                                                  alpha: 0.1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                  color: Colors.orange
                                                      .withValues(alpha: 0.3),
                                                ),
                                              ),
                                              child: Text(
                                                transaction.status
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                  color: Colors.orange,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    if (isSelected) ...[
                                      const SizedBox(height: 16),
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          border: Border.all(
                                            color: Colors.grey.withValues(
                                              alpha: 0.2,
                                            ),
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.receipt_long_rounded,
                                                  size: 16,
                                                  color: AppColors.primary,
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  'Detail Pesanan:',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.primary,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            ...transaction.details.map(
                                              (detail) => Padding(
                                                padding: const EdgeInsets.only(
                                                  bottom: 6,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                            vertical: 2,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        color: AppColors.primary
                                                            .withValues(
                                                              alpha: 0.1,
                                                            ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              4,
                                                            ),
                                                      ),
                                                      child: Text(
                                                        '${detail.quantity}x',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              AppColors.primary,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Expanded(
                                                      child: Text(
                                                        detail.nameProduct,
                                                        style: const TextStyle(
                                                          fontSize: 13,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      idrFormat(
                                                        detail.quantity *
                                                            detail.price,
                                                      ),
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    failure: (message) => _buildErrorState(message),
                    transactionCreated: (_) => const SizedBox.shrink(),
                    transactionUpdated: (_) => const SizedBox.shrink(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.pending_actions_outlined,
              size: 48,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: Colors.red[400]),
          const SizedBox(height: 16),
          Text(
            'Error: $message',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red[600]),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              context.read<PendingTransactionBloc>().add(
                const PendingTransactionEvent.fetchPendingTransactions(),
              );
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Coba Lagi'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentForm() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.payment_rounded,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Form Pembayaran',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Selected transactions summary
            if (_selectedTransactions.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.05),
                      AppColors.primary.withValues(alpha: 0.02),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.shopping_cart_rounded,
                          size: 16,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Pesanan dipilih (${_selectedTransactions.length}):',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ..._selectedTransactions.map(
                      (transaction) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '${transaction.orderNo} - ${transaction.customerName}',
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                            Text(
                              idrFormat(transaction.grandTotal),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Pembayaran:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          idrFormat(totalAmount.toString()),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],

            // Payment method selection
            BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox.shrink(),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  success: (paymentMethods) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: DropdownButtonFormField<int>(
                      value: _selectedPaymentMethodId,
                      decoration: const InputDecoration(
                        labelText: 'Metode Pembayaran',
                        prefixIcon: Icon(Icons.credit_card_rounded),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                      ),
                      items: paymentMethods
                          .map(
                            (method) => DropdownMenuItem(
                              value: method.id,
                              child: Text(method.name),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedPaymentMethodId = value;
                        });
                      },
                    ),
                  ),
                  failure: (message) => Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red[200]!),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline, color: Colors.red[600]),
                        const SizedBox(width: 8),
                        Text(
                          'Error: $message',
                          style: TextStyle(color: Colors.red[600]),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            // Cash payment amount (only for cash payment method)
            if (_selectedPaymentMethodId == 1) ...[
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: TextFormField(
                  controller: _tenderedAmountController,
                  decoration: const InputDecoration(
                    labelText: 'Jumlah Uang Diterima',
                    prefixIcon: Icon(Icons.attach_money_rounded),
                    prefixText: 'Rp ',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],

            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: TextFormField(
                controller: _noteController,
                decoration: const InputDecoration(
                  labelText: 'Catatan (Opsional)',
                  prefixIcon: Icon(Icons.note_rounded),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
                maxLines: 3,
              ),
            ),

            const Spacer(),

            // Payment button
            SizedBox(
              width: double.infinity,
              child: BlocBuilder<PaymentSettlementBloc, PaymentSettlementState>(
                builder: (context, state) {
                  final isLoading = state.maybeWhen(
                    loading: () => true,
                    orElse: () => false,
                  );

                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary,
                          AppColors.primary.withValues(alpha: 0.8),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _processPayment,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.payment_rounded, size: 20),
                                const SizedBox(width: 8),
                                const Text(
                                  'Proses Pembayaran',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
