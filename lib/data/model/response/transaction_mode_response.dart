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
  final int transactionId;
  final String orderNo;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String tableNo;
  final String customerName;
  final int userId;
  final String serviceType;
  final String status;
  final String grandTotal;
  final String paidTotal;
  final String balanceDue;
  final DateTime? paidAt;
  final List<TransactionDetail> details;

  Transaction({
    required this.transactionId,
    required this.orderNo,
    required this.createdAt,
    required this.updatedAt,
    required this.tableNo,
    required this.customerName,
    required this.userId,
    required this.serviceType,
    required this.status,
    required this.grandTotal,
    required this.paidTotal,
    required this.balanceDue,
    this.paidAt,
    required this.details,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    transactionId: json["transaction_id"],
    orderNo: json["order_no"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    tableNo: json["table_no"],
    customerName: json["customer_name"],
    userId: json["user_id"],
    serviceType: json["service_type"],
    status: json["status"],
    grandTotal: json["grand_total"],
    paidTotal: json["paid_total"],
    balanceDue: json["balance_due"],
    paidAt: json["paid_at"] != null ? DateTime.parse(json["paid_at"]) : null,
    details: List<TransactionDetail>.from(
      json["details"].map((x) => TransactionDetail.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "transaction_id": transactionId,
    "order_no": orderNo,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "table_no": tableNo,
    "customer_name": customerName,
    "user_id": userId,
    "service_type": serviceType,
    "status": status,
    "grand_total": grandTotal,
    "paid_total": paidTotal,
    "balance_due": balanceDue,
    "paid_at": paidAt?.toIso8601String(),
    "details": List<dynamic>.from(details.map((x) => x.toJson())),
  };
}

class TransactionDetail {
  final int id;
  final int? productId;
  final String productName;
  final int quantity;
  final String? flavor;
  final String? spicyLevel;
  final String? note;
  final String price;
  final String subtotal;

  TransactionDetail({
    required this.id,
    this.productId,
    required this.productName,
    required this.quantity,
    this.flavor,
    this.spicyLevel,
    this.note,
    required this.price,
    required this.subtotal,
  });

  factory TransactionDetail.fromJson(Map<String, dynamic> json) =>
      TransactionDetail(
        id: json["id"],
        productId: json["product_id"],
        productName: json["product_name"],
        quantity: json["quantity"],
        flavor: json["flavor"],
        spicyLevel: json["spicy_level"],
        note: json["note"],
        price: json["price"].toString(),
        subtotal: json["subtotal"].toString(),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "product_name": productName,
    "quantity": quantity,
    "flavor": flavor,
    "spicy_level": spicyLevel,
    "note": note,
    "price": price,
    "subtotal": subtotal,
  };
}
