import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/presentations/dashboard/payment/paymentpage/bloc/payment_page_bloc.dart';
import 'package:posmobile/shared/config/app_colors.dart';

class TableFilterDropdown extends StatelessWidget {
  const TableFilterDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentPageBloc, PaymentPageState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loaded:
              (
                allTransactions,
                selectedTableNo,
                selectedTransactions,
                availableTables,
              ) {
                if (availableTables.isEmpty) {
                  return const SizedBox.shrink();
                }

                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.2),
                        ),
                      ),
                      child: DropdownButtonFormField<String>(
                        key: const ValueKey('table_filter_dropdown'),
                        value: selectedTableNo,
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
                          ...availableTables.map(
                            (tableNo) => DropdownMenuItem<String>(
                              value: tableNo,
                              child: Row(
                                children: [
                                  const SizedBox(width: 8),
                                  Text('Meja $tableNo'),
                                ],
                              ),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          context.read<PaymentPageBloc>().add(
                            PaymentPageEvent.selectTable(tableNo: value),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Transaction count info
                    _TransactionCountInfo(
                      selectedTableNo: selectedTableNo,
                      availableTables: availableTables,
                    ),
                  ],
                );
              },
        );
      },
    );
  }
}

class _TransactionCountInfo extends StatelessWidget {
  final String? selectedTableNo;
  final List<String> availableTables;

  const _TransactionCountInfo({
    required this.selectedTableNo,
    required this.availableTables,
  });

  @override
  Widget build(BuildContext context) {
    final paymentPageBloc = context.read<PaymentPageBloc>();
    final filteredTransactions = paymentPageBloc.getFilteredTransactions();

    return Row(
      children: [
        Icon(Icons.info_outline, size: 16, color: AppColors.primary),
        const SizedBox(width: 8),
        Text(
          selectedTableNo != null
              ? 'Menampilkan ${filteredTransactions.length} pesanan untuk Meja $selectedTableNo'
              : 'Menampilkan ${filteredTransactions.length} pesanan dari ${availableTables.length} meja',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
