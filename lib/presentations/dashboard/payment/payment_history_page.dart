import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/bloc/payment_settlement/payment_settlement_bloc.dart';
import 'package:posmobile/data/model/response/payment_response.dart';
import 'package:posmobile/shared/config/app_colors.dart';
import 'package:posmobile/shared/mixins/responsive_mixin.dart';
import 'package:posmobile/shared/widgets/idr_format.dart';

import 'package:intl/intl.dart';
import 'dart:math';

import 'package:posmobile/shared/widgets/top_bar.dart';

class PaymentHistoryPage extends StatefulWidget {
  const PaymentHistoryPage({super.key});

  @override
  State<PaymentHistoryPage> createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage>
    with ResponsiveMixin {
  DateTime _selectedDate = DateTime.now();
  String _viewMode = 'daily';
  int _currentPage = 1;
  final int _itemsPerPage = 15;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PaymentSettlementBloc>().add(
        const PaymentSettlementEvent.fetchPayments(),
      );
    });
  }

  void _onPageChanged(int newPage) {
    setState(() {
      _currentPage = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,

      body: BlocBuilder<PaymentSettlementBloc, PaymentSettlementState>(
        builder: (context, state) {
          return Column(
            children: [
              TopBar(
                searchController: null,
                onSearchChanged: null,
                hintText: 'Cari Pembayaran',
              ),
              _buildViewModeControl(),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    context.read<PaymentSettlementBloc>().add(
                      const PaymentSettlementEvent.fetchPayments(),
                    );
                  },
                  child: state.when(
                    initial: () => const Center(
                      child: Text('Tarik ke bawah untuk memuat data.'),
                    ),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    paymentsLoaded: (allPayments) {
                      if (_viewMode == 'daily') {
                        return _buildDailyView(allPayments);
                      } else {
                        return _buildAllView(allPayments);
                      }
                    },
                    paymentSettled: (response) => const SizedBox.shrink(),
                    paymentPolling: (payment) =>
                        const Center(child: CircularProgressIndicator()),
                    paymentCompleted: (payment) =>
                        const Center(child: Text('Pembayaran berhasil.')),
                    paymentFailed: (payment, reason) =>
                        Center(child: Text('Pembayaran gagal: $reason')),
                    paymentExpired: (payment) =>
                        const Center(child: Text('Pembayaran kadaluarsa.')),
                    paymentRetried: (response) =>
                        const Center(child: Text('Pembayaran dicoba kembali.')),
                    paymentCancelled: (response) =>
                        const Center(child: Text('Pembayaran dibatalkan.')),
                    failure: (message) => Center(
                      child: Text(
                        'Error: $message',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildViewModeControl() {
    final theme = Theme.of(context);
    return safeContainer(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Center(
        child: SizedBox(
          width: 200,
          child: SegmentedControl(
            value: _viewMode,
            options: {
              'daily': Text('Harian', style: theme.textTheme.bodyLarge),
              'all': Text('Semua', style: theme.textTheme.bodyLarge),
            },
            onChanged: (value) {
              setState(() {
                _viewMode = value!;
                if (_viewMode == 'all') {
                  _currentPage = 1;
                }
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDailyView(List<PaymentData> allPayments) {
    final theme = Theme.of(context);
    final selectedDate = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
    );
    final filteredPayments = allPayments.where((payment) {
      final paymentDate = DateTime(
        payment.receivedAt.year,
        payment.receivedAt.month,
        payment.receivedAt.day,
      );
      return paymentDate.isAtSameMomentAs(selectedDate);
    }).toList();

    final totalAmount = filteredPayments.fold<double>(
      0.0,
      (sum, item) => sum + double.parse(item.amount),
    );

    return Column(
      children: [
        _buildDatePicker(allPayments),
        _buildDailySummary(totalAmount, filteredPayments.length),
        if (filteredPayments.isEmpty)
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inbox,
                    size: 48,
                    color: theme.colorScheme.outlineVariant.withValues(
                      alpha: 0.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Tidak ada riwayat untuk tanggal ini.',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          )
        else
          Expanded(
            child: safeListView(
              itemCount: filteredPayments.length,
              itemBuilder: (context, index) {
                return _buildPaymentListItem(context, filteredPayments[index]);
              },
            ),
          ),
      ],
    );
  }

  Widget _buildAllView(List<PaymentData> allPayments) {
    final theme = Theme.of(context);
    if (allPayments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox,
              size: 48,
              color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Tidak ada riwayat pembayaran.',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      );
    }

    final sortedPayments = allPayments.toList()
      ..sort((a, b) => b.receivedAt.compareTo(a.receivedAt));

    final totalPages = (sortedPayments.length / _itemsPerPage).ceil();
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex = min(startIndex + _itemsPerPage, sortedPayments.length);
    final displayedPayments = sortedPayments.sublist(startIndex, endIndex);

    return Column(
      children: [
        _buildAllSummary(sortedPayments.length),
        Expanded(
          child: safeListView(
            itemCount: displayedPayments.length,
            itemBuilder: (context, index) {
              return _buildPaymentListItem(context, displayedPayments[index]);
            },
          ),
        ),
        _buildPaginationControl(totalPages),
      ],
    );
  }

  Widget _buildAllSummary(int totalPayments) {
    final theme = Theme.of(context);
    return safeContainer(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: safeRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          responsiveText(
            'Total Transaksi',
            context: context,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ).flex,
          responsiveText(
            '$totalPayments',
            context: context,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            preserveImportantText: true,
          ).flex,
        ],
      ),
    );
  }

  Widget _buildPaginationControl(int totalPages) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 28),
      child: safeContainer(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: safeRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            responsiveButton(
              onPressed: _currentPage > 1
                  ? () => _onPageChanged(_currentPage - 1)
                  : null,
              context: context,
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
              ),
              child: responsiveText(
                'Sebelumnya',
                context: context,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ),
            responsiveText(
              'Halaman $_currentPage dari $totalPages',
              context: context,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            responsiveButton(
              onPressed: _currentPage < totalPages
                  ? () => _onPageChanged(_currentPage + 1)
                  : null,
              context: context,
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
              ),
              child: responsiveText(
                'Berikutnya',
                context: context,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Widget Kustom ---

  Widget _buildDatePicker(List<PaymentData> allPayments) {
    final theme = Theme.of(context);
    final now = DateTime.now();
    final dates = List<DateTime>.generate(
      30,
      (i) => now.subtract(Duration(days: i)),
    );

    // Buat set dari tanggal-tanggal yang memiliki transaksi untuk pencarian cepat
    final transactionDates = allPayments
        .map(
          (payment) => DateTime(
            payment.receivedAt.year,
            payment.receivedAt.month,
            payment.receivedAt.day,
          ),
        )
        .toSet();

    return safeContainer(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        reverse: true,
        child: safeRow(
          children: dates.map((date) {
            final isSelected =
                _selectedDate.day == date.day &&
                _selectedDate.month == date.month &&
                _selectedDate.year == date.year;

            final hasTransactionsOnDate = transactionDates.contains(
              DateTime(date.year, date.month, date.day),
            );

            Color backgroundColor;
            Color dayColor;
            Color weekdayColor;
            List<BoxShadow> boxShadow = [];

            if (isSelected) {
              backgroundColor = theme.colorScheme.primary;
              dayColor = theme.colorScheme.onPrimary;
              weekdayColor = theme.colorScheme.onPrimary;
              boxShadow = [
                BoxShadow(
                  color: theme.colorScheme.primary.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ];
            } else if (hasTransactionsOnDate) {
              backgroundColor = theme.colorScheme.surfaceContainerHighest;
              dayColor = theme.colorScheme.onSurface;
              weekdayColor = theme.colorScheme.onSurfaceVariant;
            } else {
              backgroundColor = theme.colorScheme.surface;
              dayColor = theme.colorScheme.onSurfaceVariant;

              weekdayColor = theme.colorScheme.onSurfaceVariant;
            }

            return GestureDetector(
              onTap: () {
                setState(() => _selectedDate = date);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                width: 60,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  boxShadow: boxShadow,
                ),
                child: safeColumn(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    responsiveText(
                      DateFormat('EEE').format(date),
                      context: context,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: weekdayColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    responsiveText(
                      DateFormat('dd').format(date),
                      context: context,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: dayColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildDailySummary(double totalAmount, int totalTransactions) {
    final theme = Theme.of(context);
    return safeContainer(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: safeRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildSummaryItem('Pendapatan Harian', idrFormat(totalAmount)),
          _buildSummaryItem('Transaksi', '$totalTransactions Transaksi'),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    final theme = Theme.of(context);
    return safeColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        responsiveText(
          label,
          context: context,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        responsiveText(
          value,
          context: context,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentListItem(BuildContext context, PaymentData payment) {
    final theme = Theme.of(context);
    final statusColor = _getStatusColor(payment.status);
    return InkWell(
      onTap: () => _showPaymentDetailsSheet(context, payment),
      child: safeContainer(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: safeRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            safeColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                responsiveText(
                  'PaymentID: #${payment.id}',
                  context: context,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),

                responsiveText(
                  "Pelanggan: ${payment.transactions.isNotEmpty ? payment.transactions.first.customerName : 'Tidak ada'}",
                  context: context,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                safeRow(
                  children: [
                    responsiveText(
                      'Harga: ',
                      context: context,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ).flex,
                    guaranteedPriceText(
                      idrFormat(double.parse(payment.amount)),
                      context: context,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                responsiveText(
                  '${DateFormat('HH:mm').format(payment.receivedAt)} • ${payment.method}',
                  context: context,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ).flex,
            safeContainer(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: responsiveText(
                payment.status.toUpperCase(),
                context: context,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'paid':
        return AppColors.successLight;
      case 'failed':
        return AppColors.errorLight;
      case 'cancelled':
        return AppColors.warning;
      case 'expired':
        return AppColors.tertiaryDark;
      default:
        return Colors.grey;
    }
  }

  void _showPaymentDetailsSheet(BuildContext context, PaymentData payment) {
    final theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return safeContainer(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            color: theme.bottomSheetTheme.backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: safeColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: theme.dividerColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Text(
                  'Detail Pembayaran',
                  style: theme.dialogTheme.titleTextStyle,
                ),
                const SizedBox(height: 24),
                _buildInfoSection('Ringkasan Pembayaran', [
                  _buildInfoRow('ID Pembayaran', '#${payment.id}'),
                  _buildInfoRow(
                    'Total',
                    idrFormat(double.parse(payment.amount)),
                    isBold: true,
                  ),
                  _buildInfoRow('Metode', payment.method),
                  _buildInfoRow(
                    'Status',
                    payment.status.toUpperCase(),
                    valueColor: _getStatusColor(payment.status),
                  ),
                  _buildInfoRow(
                    'Tanggal',
                    DateFormat('dd MMM yyyy, HH:mm').format(payment.receivedAt),
                  ),
                  _buildInfoRow('Kasir', payment.cashier ?? '-'),
                  if (payment.note != null && payment.note!.isNotEmpty)
                    _buildInfoRow('Catatan', payment.note!),
                ]),
                if (payment.tenderedAmount != null &&
                    double.parse(payment.tenderedAmount!) > 0)
                  _buildInfoSection('Informasi Uang', [
                    _buildInfoRow(
                      'Uang Diterima',
                      idrFormat(double.parse(payment.tenderedAmount!)),
                    ),
                    _buildInfoRow(
                      'Kembalian',
                      idrFormat(double.parse(payment.changeAmount)),
                    ),
                  ]),
                if (payment.transactions.isNotEmpty)
                  _buildInfoSection('Rincian Transaksi', [
                    ...payment.transactions.map(
                      (transaction) => _buildTransactionDetail(transaction),
                    ),
                  ]),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoSection(String title, List<Widget> children) {
    final theme = Theme.of(context);
    return safeColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildInfoRow(
    String label,
    String value, {
    Color? valueColor,
    bool isBold = false,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: safeRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          responsiveText(
            label,
            context: context,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          responsiveText(
            value,
            context: context,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              color: valueColor ?? theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionDetail(PaymentTransaction transaction) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: safeContainer(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.cardColor.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: safeColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Pesanan', transaction.orderNo),
            _buildInfoRow('Pelanggan', transaction.customerName),
            const Divider(height: 16),
            Text(
              'Item:',
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...transaction.detailTransaction.map(
              (detail) => _buildProductRow(detail),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductRow(PaymentTransactionDetail detail) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: safeRow(
        children: [
          responsiveText(
            '${detail.quantity}x ${detail.productName}',
            context: context,
            style: theme.textTheme.bodyMedium,
          ).expand,
          responsiveText(
            idrFormat(double.parse(detail.subtotal)),
            context: context,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ).flex,
        ],
      ),
    );
  }
}

class SegmentedControl extends StatelessWidget {
  final String value;
  final Map<String, Widget> options;
  final ValueChanged<String?> onChanged;

  const SegmentedControl({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: options.entries.map((entry) {
          final isSelected = value == entry.key;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(entry.key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected
                      ? theme.colorScheme.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: theme.colorScheme.primary.withValues(
                              alpha: 0.1,
                            ),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: DefaultTextStyle(
                    style: TextStyle(
                      color: isSelected
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.onSurfaceVariant,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    child: entry.value,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
