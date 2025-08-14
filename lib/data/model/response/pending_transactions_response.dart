import 'dart:convert';

PendingTransactionsResponse pendingTransactionsResponseFromJson(String str) =>
    PendingTransactionsResponse.fromJson(json.decode(str));

String pendingTransactionsResponseToJson(PendingTransactionsResponse data) =>
    json.encode(data.toJson());

class PendingTransactionsResponse {
  final bool success;
  final String message;
  final List<PendingTransaction> data;

  PendingTransactionsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PendingTransactionsResponse.fromJson(Map<String, dynamic> json) =>
      PendingTransactionsResponse(
        success: json["success"],
        message: json["message"],
        data: List<PendingTransaction>.from(
          json["data"].map((x) => PendingTransaction.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class PendingTransaction {
  final int transactionId;
  final String orderNo;
  final DateTime createdAt;
  final String tableNo;
  final String customerName;
  final int userId;
  final String serviceType;
  final String status;
  final String grandTotal;
  final String paidTotal;
  final String balanceDue;
  final List<TransactionDetailData> details;

  PendingTransaction({
    required this.transactionId,
    required this.orderNo,
    required this.createdAt,
    required this.tableNo,
    required this.customerName,
    required this.userId,
    required this.serviceType,
    required this.status,
    required this.grandTotal,
    required this.paidTotal,
    required this.balanceDue,
    required this.details,
  });

  factory PendingTransaction.fromJson(Map<String, dynamic> json) =>
      PendingTransaction(
        transactionId: json["transaction_id"],
        orderNo: json["order_no"],
        createdAt: DateTime.parse(json["created_at"]),
        tableNo: json["table_no"],
        customerName: json["customer_name"],
        userId: json["user_id"],
        serviceType: json["service_type"],
        status: json["status"],
        grandTotal: json["grand_total"],
        paidTotal: json["paid_total"],
        balanceDue: json["balance_due"],
        details: List<TransactionDetailData>.from(
          json["details"].map((x) => TransactionDetailData.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "transaction_id": transactionId,
    "order_no": orderNo,
    "created_at": createdAt.toIso8601String(),
    "table_no": tableNo,
    "customer_name": customerName,
    "user_id": userId,
    "service_type": serviceType,
    "status": status,
    "grand_total": grandTotal,
    "paid_total": paidTotal,
    "balance_due": balanceDue,
    "details": List<dynamic>.from(details.map((x) => x.toJson())),
  };
}

class TransactionDetailData {
  final int id;
  final int productId;
  final String nameProduct;
  final int quantity;
  final int? flavorId;
  final String? flavor;
  final int? spicyLevelId;
  final String? spicyLevel;
  final String? note;
  final int price;
  final int subtotal;

  TransactionDetailData({
    required this.id,
    required this.productId,
    required this.nameProduct,
    required this.quantity,
    this.flavorId,
    this.flavor,
    this.spicyLevelId,
    this.spicyLevel,
    this.note,
    required this.price,
    required this.subtotal,
  });

  factory TransactionDetailData.fromJson(Map<String, dynamic> json) =>
      TransactionDetailData(
        id: json["id"],
        productId: json["product_id"],
        nameProduct: json["name_product"],
        quantity: json["quantity"],
        flavorId: json["flavor_id"],
        flavor: json["flavor"],
        spicyLevelId: json["spicy_level_id"],
        spicyLevel: json["spicy_level"],
        note: json["note"],
        price: json["price"],
        subtotal: json["subtotal"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "name_product": nameProduct,
    "quantity": quantity,
    "flavor_id": flavorId,
    "flavor": flavor,
    "spicy_level_id": spicyLevelId,
    "spicy_level": spicyLevel,
    "note": note,
    "price": price,
    "subtotal": subtotal,
  };
}
