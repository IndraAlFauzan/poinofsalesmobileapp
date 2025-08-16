class AllTransactionModelResponse {
  bool success;
  String message;
  List<Transaction> data;

  AllTransactionModelResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AllTransactionModelResponse.fromJson(Map<String, dynamic> json) =>
      AllTransactionModelResponse(
        success: json["success"],
        message: json["message"],
        data: List<Transaction>.from(
          json["data"].map((x) => Transaction.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetByIdTransactionModelResponse {
  bool success;
  String message;
  Transaction data;

  GetByIdTransactionModelResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetByIdTransactionModelResponse.fromJson(Map<String, dynamic> json) =>
      GetByIdTransactionModelResponse(
        success: json["success"],
        message: json["message"],
        data: Transaction.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class Transaction {
  int id;
  int transactionId;
  String orderNo;
  DateTime createdAt;
  String createdAtFormatted;
  DateTime updatedAt;
  int tableId;
  String tableNo;
  String noTable;
  String customerName;
  int userId;
  String serviceType;
  String status;
  String grandTotal;
  String paidTotal;
  String balanceDue;
  DateTime? paidAt;
  String? paidAtFormatted;
  List<TransactionDetail> details;
  List<TransactionDetail> detailTransaction;

  Transaction({
    required this.id,
    required this.transactionId,
    required this.orderNo,
    required this.createdAt,
    required this.createdAtFormatted,
    required this.updatedAt,
    required this.tableId,
    required this.tableNo,
    required this.noTable,
    required this.customerName,
    required this.userId,
    required this.serviceType,
    required this.status,
    required this.grandTotal,
    required this.paidTotal,
    required this.balanceDue,
    this.paidAt,
    this.paidAtFormatted,
    required this.details,
    required this.detailTransaction,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    id: json["id"] ?? 0,
    transactionId: json["transaction_id"] ?? 0,
    orderNo: json["order_no"] ?? "",
    createdAt: _parseDateTime(json["created_at"]),
    createdAtFormatted: json["created_at_formatted"] ?? "",
    updatedAt: _parseDateTime(json["updated_at"]),
    tableId: json["table_id"] ?? 0,
    tableNo: json["table_no"] ?? "",
    noTable: json["no_table"] ?? "",
    customerName: json["customer_name"] ?? "",
    userId: json["user_id"] ?? 0,
    serviceType: json["service_type"] ?? "",
    status: json["status"] ?? "",
    grandTotal: json["grand_total"] ?? "0.00",
    paidTotal: json["paid_total"] ?? "0.00",
    balanceDue: json["balance_due"] ?? "0.00",
    paidAt: json["paid_at"] != null ? _parseDateTime(json["paid_at"]) : null,
    paidAtFormatted: json["paid_at_formatted"],
    details: json["details"] != null
        ? List<TransactionDetail>.from(
            json["details"].map((x) => TransactionDetail.fromJson(x)),
          )
        : [],
    detailTransaction: json["detail_transaction"] != null
        ? List<TransactionDetail>.from(
            json["detail_transaction"].map(
              (x) => TransactionDetail.fromJson(x),
            ),
          )
        : [],
  );

  static DateTime _parseDateTime(dynamic dateValue) {
    try {
      if (dateValue == null) return DateTime.now();
      return DateTime.parse(dateValue.toString());
    } catch (e) {
      return DateTime.now();
    }
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "transaction_id": transactionId,
    "order_no": orderNo,
    "created_at": createdAt.toIso8601String(),
    "created_at_formatted": createdAtFormatted,
    "updated_at": updatedAt.toIso8601String(),
    "table_id": tableId,
    "table_no": tableNo,
    "no_table": noTable,
    "customer_name": customerName,
    "user_id": userId,
    "service_type": serviceType,
    "status": status,
    "grand_total": grandTotal,
    "paid_total": paidTotal,
    "balance_due": balanceDue,
    "paid_at": paidAt?.toIso8601String(),
    "paid_at_formatted": paidAtFormatted,
    "details": List<dynamic>.from(details.map((x) => x.toJson())),
    "detail_transaction": List<dynamic>.from(
      detailTransaction.map((x) => x.toJson()),
    ),
  };

  // Helper methods for backward compatibility and display
  String get nameUser => customerName;
  String get paymentMethod => status == "completed" ? "Cash" : "Pending";
  int get total =>
      int.tryParse(grandTotal.replaceAll('.', '').replaceAll(',', '')) ?? 0;
}

class TransactionDetail {
  int id;
  int productId;
  String productName;
  String nameProduct;
  int quantity;
  int price;
  int subtotal;
  int? flavorId;
  String? flavor;
  int? spicyLevelId;
  String? spicyLevel;
  String? note;

  TransactionDetail({
    required this.id,
    required this.productId,
    required this.productName,
    required this.nameProduct,
    required this.quantity,
    required this.price,
    required this.subtotal,
    this.flavorId,
    this.flavor,
    this.spicyLevelId,
    this.spicyLevel,
    this.note,
  });

  factory TransactionDetail.fromJson(Map<String, dynamic> json) =>
      TransactionDetail(
        id: json["id"] ?? 0,
        productId: json["product_id"] ?? 0,
        productName: json["product_name"] ?? "",
        nameProduct: json["name_product"] ?? "",
        quantity: json["quantity"] ?? 0,
        price: json["price"] ?? 0,
        subtotal: json["subtotal"] ?? 0,
        flavorId: json["flavor_id"],
        flavor: json["flavor"],
        spicyLevelId: json["spicy_level_id"],
        spicyLevel: json["spicy_level"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "product_name": productName,
    "name_product": nameProduct,
    "quantity": quantity,
    "price": price,
    "subtotal": subtotal,
    "flavor_id": flavorId,
    "flavor": flavor,
    "spicy_level_id": spicyLevelId,
    "spicy_level": spicyLevel,
    "note": note,
  };
}
