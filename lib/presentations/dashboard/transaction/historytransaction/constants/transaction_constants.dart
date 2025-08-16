class TransactionConstants {
  // Animation durations
  static const refreshAnimationDuration = Duration(milliseconds: 800);
  static const switchAnimationDuration = Duration(milliseconds: 200);
  static const fadeAnimationDuration = Duration(milliseconds: 400);

  // UI dimensions
  static const double headerFontSize = 24.0;
  static const double subtitleFontSize = 16.0;
  static const double cardBorderRadius = 12.0;
  static const double buttonBorderRadius = 8.0;
  static const double iconSize = 20.0;
  static const double errorIconSize = 64.0;

  // Grid dimensions
  static const double rowHeight = 65.0;
  static const double headerRowHeight = 55.0;
  static const double columnFontSize = 13.0;

  // Pagination
  static const int itemsPerPage = 15;

  // Delay
  static const refreshDelay = Duration(milliseconds: 300);

  // Status types
  static const String statusCompleted = 'completed';
  static const String statusPending = 'pending';
  static const String statusCancelled = 'cancelled';

  // Status display names
  static const String statusCompletedDisplay = 'Completed';
  static const String statusPendingDisplay = 'Pending';
  static const String statusCancelledDisplay = 'Cancelled';

  // Search hints
  static const String searchHint = "Cari transaksi, customer, produk...";

  // Error messages
  static const String errorFetchingTransactions = "Error fetching transactions";
  static const String errorRefreshingTransactions =
      "Error refreshing transactions";
  static const String errorSearchingTransactions =
      "Error searching transactions";

  // UI text
  static const String transactionHistoryTitle = "Transaction History";
  static const String transactionHistorySubtitle =
      "List of transactions made by customers";
  static const String refreshButtonText = "Refresh";
  static const String refreshingButtonText = "Refreshing...";
  static const String retryButtonText = "Coba Lagi";
  static const String loadingText = "Loading transactions...";
  static const String refreshingText = "Refreshing transactions...";
  static const String pleaseWaitText = "Silakan tunggu...";
  static const String noTransactionsText = "No transactions found";
  static const String adjustSearchText = "Try adjusting your search criteria";
}
