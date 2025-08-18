import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/bloc/table/table_bloc.dart';
import 'package:posmobile/data/model/response/table_response.dart';
import 'package:posmobile/shared/config/app_colors.dart';

class TableDropdown extends StatefulWidget {
  final Function(TableData?)? onTableChanged;

  const TableDropdown({super.key, this.onTableChanged});

  @override
  State<TableDropdown> createState() => _TableDropdownState();
}

class _TableDropdownState extends State<TableDropdown> {
  @override
  void initState() {
    super.initState();
    // Fetch tables when widget is initialized
    context.read<TableBloc>().add(const TableEvent.fetchTables());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TableBloc, TableState>(
      builder: (context, state) {
        return state.when(
          initial: () => Container(
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey),
            ),
            child: const Center(child: Text('Loading...')),
          ),
          loading: () => Container(
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey),
            ),
            child: const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          ),
          failure: (message) => Container(
            height: 56,
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.red),
            ),
            child: Center(
              child: Text(
                'Error loading tables',
                style: TextStyle(color: Colors.red[700]),
              ),
            ),
          ),
          success: (tables) {
            final activeTables = tables
                .where((table) => table.isActive)
                .toList();

            if (activeTables.isEmpty) {
              return Container(
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: const Center(child: Text('No tables available')),
              );
            }

            // Filter tables based on search query
            final filteredTables = activeTables;

            return CustomDropdown<TableData>(
              decoration: CustomDropdownDecoration(
                closedBorder: Border.all(color: Colors.grey),
                expandedBorder: Border.all(color: AppColors.primary),
                closedFillColor: AppColors.surface,
                expandedFillColor: AppColors.surface,
              ),
              hintText: "Pilih Meja",
              items: filteredTables,
              excludeSelected: false,
              listItemBuilder: (context, item, isSelected, onItemSelect) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary.withValues(alpha: 0.1)
                        : null,
                  ),
                  child: Text(
                    " ${item.tableNo} ",
                    style: TextStyle(
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textPrimary,
                    ),
                  ),
                );
              },
              headerBuilder: (context, selectedItem, enabled) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 1,
                    horizontal: 16,
                  ),
                  child: Text(
                    selectedItem.tableNo,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.textPrimary,
                    ),
                  ),
                );
              },
              onChanged: widget.onTableChanged,
            );
          },
        );
      },
    );
  }
}
