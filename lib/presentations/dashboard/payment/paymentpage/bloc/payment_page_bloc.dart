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
    on<_SetPaymentInfo>(_onSetPaymentInfo);
  }

  void _onUpdateTransactions(
    _UpdateTransactions event,
    Emitter<PaymentPageState> emit,
  ) {
    final availableTables = _getAvailableTables(event.transactions);

    // Validate selected table still exists
    String? validatedSelectedTable;
    List<PendingTransaction> validatedSelectedTransactions = [];

    if (state is _Loaded) {
      final currentState = state as _Loaded;
      final currentSelectedTable = currentState.selectedTableNo;
      if (currentSelectedTable != null &&
          availableTables.contains(currentSelectedTable)) {
        validatedSelectedTable = currentSelectedTable;
      }

      // Update selected transactions with fresh data while preserving selections
      validatedSelectedTransactions = currentState.selectedTransactions
          .map((selected) {
            // Find the updated version of this transaction
            try {
              final updatedTransaction = event.transactions.firstWhere(
                (t) => t.transactionId == selected.transactionId,
              );
              return updatedTransaction;
            } catch (e) {
              // Transaction no longer exists, remove from selection
              return null;
            }
          })
          .where((t) => t != null)
          .cast<PendingTransaction>()
          .where(
            (t) =>
                validatedSelectedTable == null ||
                t.tableNo == validatedSelectedTable,
          )
          .toList();
    }

    emit(
      PaymentPageState.loaded(
        allTransactions: event.transactions,
        selectedTableNo: validatedSelectedTable,
        selectedTransactions: validatedSelectedTransactions,
        availableTables: availableTables,
        paymentMethodId: state is _Loaded
            ? (state as _Loaded).paymentMethodId
            : null,
        paymentMethodName: state is _Loaded
            ? (state as _Loaded).paymentMethodName
            : null,
        tenderedAmount: state is _Loaded
            ? (state as _Loaded).tenderedAmount
            : null,
        note: state is _Loaded ? (state as _Loaded).note : null,
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
        currentState.copyWith(
          selectedTableNo: null,
          selectedTransactions: [],
          paymentMethodId: null,
          paymentMethodName: null,
          tenderedAmount: null,
          note: null,
        ),
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

  void _onSetPaymentInfo(
    _SetPaymentInfo event,
    Emitter<PaymentPageState> emit,
  ) {
    final currentState = state;
    if (currentState is _Loaded) {
      emit(
        currentState.copyWith(
          paymentMethodId: event.paymentMethodId,
          paymentMethodName: event.paymentMethodName,
          tenderedAmount: event.tenderedAmount,
          note: event.note,
        ),
      );
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

  PendingTransaction? getTransactionById(int transactionId) {
    final currentState = state;
    if (currentState is _Loaded) {
      try {
        // Always return the latest data from allTransactions
        return currentState.allTransactions.firstWhere(
          (t) => t.transactionId == transactionId,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  // Helper method to get updated transaction data after changes
  PendingTransaction getUpdatedTransaction(PendingTransaction original) {
    final updated = getTransactionById(original.transactionId);
    return updated ?? original;
  }
}
