import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/presentations/dashboard/transaction/historytransaction/bloc/history_transaction_bloc.dart';
import 'package:posmobile/shared/config/app_colors.dart';

class TransactionFilterWidget extends StatefulWidget {
  const TransactionFilterWidget({super.key});

  @override
  State<TransactionFilterWidget> createState() =>
      _TransactionFilterWidgetState();
}

class _TransactionFilterWidgetState extends State<TransactionFilterWidget> {
  String? _selectedStatus;
  DateTime? _startDate;
  DateTime? _endDate;

  final _customerController = TextEditingController();
  final _minAmountController = TextEditingController();
  final _maxAmountController = TextEditingController();

  @override
  void dispose() {
    _customerController.dispose();
    _minAmountController.dispose();
    _maxAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.filter_list, color: AppColors.primary),
      onPressed: () => _showFilterDialog(context),
      tooltip: 'Filter Transactions',
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.filter_list, color: AppColors.primary),
                  const SizedBox(width: 8),
                  const Text('Filter Transactions'),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status Filter
                    const Text(
                      'Status',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _selectedStatus,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Select status',
                      ),
                      items: [
                        const DropdownMenuItem(
                          value: null,
                          child: Text('All Status'),
                        ),
                        const DropdownMenuItem(
                          value: 'paid',
                          child: Text('Paid'),
                        ),
                        const DropdownMenuItem(
                          value: 'unpaid',
                          child: Text('Unpaid'),
                        ),
                        const DropdownMenuItem(
                          value: 'completed',
                          child: Text('Completed'),
                        ),
                        const DropdownMenuItem(
                          value: 'pending',
                          child: Text('Pending'),
                        ),
                        const DropdownMenuItem(
                          value: 'cancelled',
                          child: Text('Cancelled'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedStatus = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    // Date Range Filter
                    const Text(
                      'Date Range',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () =>
                                _selectDate(context, true, setState),
                            icon: const Icon(Icons.calendar_today),
                            label: Text(
                              _startDate == null
                                  ? 'Start Date'
                                  : '${_startDate!.day}/${_startDate!.month}/${_startDate!.year}',
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () =>
                                _selectDate(context, false, setState),
                            icon: const Icon(Icons.calendar_today),
                            label: Text(
                              _endDate == null
                                  ? 'End Date'
                                  : '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Customer Name Filter
                    const Text(
                      'Customer Name',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _customerController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter customer name',
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Amount Range Filter
                    const Text(
                      'Amount Range',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _minAmountController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Min amount',
                              prefixText: 'Rp ',
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _maxAmountController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Max amount',
                              prefixText: 'Rp ',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    _clearFilters();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Clear'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _applyFilters();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Apply'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _selectDate(
    BuildContext context,
    bool isStartDate,
    StateSetter setState,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate
          ? _startDate ?? DateTime.now()
          : _endDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _applyFilters() {
    final filter = TransactionFilter(
      status: _selectedStatus,
      startDate: _startDate,
      endDate: _endDate,
      customerName: _customerController.text.trim().isEmpty
          ? null
          : _customerController.text.trim(),
      minAmount: _minAmountController.text.trim().isEmpty
          ? null
          : double.tryParse(_minAmountController.text.trim()),
      maxAmount: _maxAmountController.text.trim().isEmpty
          ? null
          : double.tryParse(_maxAmountController.text.trim()),
    );

    context.read<HistoryTransactionBloc>().add(
      HistoryTransactionEvent.filterTransactions(filter),
    );
  }

  void _clearFilters() {
    setState(() {
      _selectedStatus = null;
      _startDate = null;
      _endDate = null;
      _customerController.clear();
      _minAmountController.clear();
      _maxAmountController.clear();
    });

    context.read<HistoryTransactionBloc>().add(
      const HistoryTransactionEvent.clearFilters(),
    );
  }
}
