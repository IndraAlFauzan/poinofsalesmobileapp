import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:posmobile/data/model/response/pending_transactions_response.dart';

part 'payment_page_bloc.freezed.dart';
part 'payment_page_event.dart';
part 'payment_page_state.dart';

class PaymentPageBloc extends Bloc<PaymentPageEvent, PaymentPageState> {
  PaymentPageBloc() : super(const PaymentPageState.initial()) {
    on<_UpdateTransactions>(_onUpdateTransactions);
    on<_SelectTable>(_onSelectTable);
    on<_ToggleTransactionSelection>(_onToggleTransactionSelection);
    on<_ClearSelections>(_onClearSelections);
    on<_ValidateTableSelection>(_onValidateTableSelection);
  }

  void _onUpdateTransactions(
    _UpdateTransactions event,
    Emitter<PaymentPageState> emit,
  ) {
    final currentState = state;

    // Check if data actually changed
    if (currentState is _Loaded) {
      final currentTransactions = currentState.allTransactions;
      if (currentTransactions.length == event.transactions.length &&
          currentTransactions.every(
            (t) => event.transactions.any(
              (nt) => nt.transactionId == t.transactionId,
            ),
          )) {
        return; // No change needed
      }
    }

    final availableTables = _getAvailableTables(event.transactions);

    // Validate selected table still exists
    String? validatedSelectedTable;
    List<PendingTransaction> validatedSelectedTransactions = [];

    if (currentState is _Loaded) {
      final currentSelectedTable = currentState.selectedTableNo;
      if (currentSelectedTable != null &&
          availableTables.contains(currentSelectedTable)) {
        validatedSelectedTable = currentSelectedTable;
        // Keep only selected transactions that still exist and match the table
        validatedSelectedTransactions = currentState.selectedTransactions
            .where(
              (selected) =>
                  event.transactions.any(
                    (t) => t.transactionId == selected.transactionId,
                  ) &&
                  (validatedSelectedTable == null ||
                      selected.tableNo == validatedSelectedTable),
            )
            .toList();
      }
    }

    emit(
      PaymentPageState.loaded(
        allTransactions: event.transactions,
        selectedTableNo: validatedSelectedTable,
        selectedTransactions: validatedSelectedTransactions,
        availableTables: availableTables,
      ),
    );
  }

  void _onSelectTable(_SelectTable event, Emitter<PaymentPageState> emit) {
    final currentState = state;
    if (currentState is _Loaded) {
      emit(
        currentState.copyWith(
          selectedTableNo: event.tableNo,
          selectedTransactions: [], // Clear selections when changing table
        ),
      );
    }
  }

  void _onToggleTransactionSelection(
    _ToggleTransactionSelection event,
    Emitter<PaymentPageState> emit,
  ) {
    final currentState = state;
    if (currentState is _Loaded) {
      final selectedTransactions = List<PendingTransaction>.from(
        currentState.selectedTransactions,
      );

      if (selectedTransactions.any(
        (t) => t.transactionId == event.transaction.transactionId,
      )) {
        selectedTransactions.removeWhere(
          (t) => t.transactionId == event.transaction.transactionId,
        );
      } else {
        selectedTransactions.add(event.transaction);
      }

      emit(currentState.copyWith(selectedTransactions: selectedTransactions));
    }
  }

  void _onClearSelections(
    _ClearSelections event,
    Emitter<PaymentPageState> emit,
  ) {
    final currentState = state;
    if (currentState is _Loaded) {
      emit(
        currentState.copyWith(selectedTableNo: null, selectedTransactions: []),
      );
    }
  }

  void _onValidateTableSelection(
    _ValidateTableSelection event,
    Emitter<PaymentPageState> emit,
  ) {
    final currentState = state;
    if (currentState is _Loaded) {
      final availableTables = currentState.availableTables;
      if (currentState.selectedTableNo != null &&
          !availableTables.contains(currentState.selectedTableNo)) {
        emit(
          currentState.copyWith(
            selectedTableNo: null,
            selectedTransactions: [],
          ),
        );
      }
    }
  }

  List<String> _getAvailableTables(List<PendingTransaction> transactions) {
    final tables = transactions.map((t) => t.tableNo).toSet().toList();
    tables.sort(
      (a, b) =>
          int.tryParse(a)?.compareTo(int.tryParse(b) ?? 0) ?? a.compareTo(b),
    );
    return tables;
  }

  // Getters for business logic
  List<PendingTransaction> getFilteredTransactions() {
    final currentState = state;
    if (currentState is _Loaded) {
      var filtered = List<PendingTransaction>.from(
        currentState.allTransactions,
      );

      // Filter by selected table if any
      if (currentState.selectedTableNo != null) {
        filtered = filtered
            .where((t) => t.tableNo == currentState.selectedTableNo)
            .toList();
      }

      // Sort by creation time (oldest first)
      filtered.sort((a, b) => a.createdAt.compareTo(b.createdAt));

      return filtered;
    }
    return [];
  }

  double getTotalAmount() {
    final currentState = state;
    if (currentState is _Loaded) {
      return currentState.selectedTransactions.fold(
        0.0,
        (sum, transaction) => sum + double.parse(transaction.grandTotal),
      );
    }
    return 0.0;
  }

  bool isTransactionSelected(PendingTransaction transaction) {
    final currentState = state;
    if (currentState is _Loaded) {
      return currentState.selectedTransactions.any(
        (t) => t.transactionId == transaction.transactionId,
      );
    }
    return false;
  }

  String getWaitingTimeText(DateTime createdAt) {
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

  bool isHighPriority(DateTime createdAt) {
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    return difference.inMinutes > 30;
  }
}
