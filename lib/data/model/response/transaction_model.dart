import 'dart:convert';
import 'package:posmobile/data/model/response/payment_response.dart';

// Universal Transaction model untuk semua kasus penggunaan
class Transaction {
  final int transactionId;
  final String orderNo;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? tableNo;
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
    this.tableNo,
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
    transactionId: json["transaction_id"] ?? json["id"],
    orderNo: json["order_no"]?.toString() ?? "",
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    tableNo: json["table_no"]?.toString(),
    customerName: json["customer_name"]?.toString() ?? "",
    userId: json["user_id"] ?? 0,
    serviceType: json["service_type"]?.toString() ?? "",
    status: json["status"]?.toString() ?? "",
    grandTotal: json["grand_total"]?.toString() ?? "0",
    paidTotal: json["paid_total"]?.toString() ?? "0",
    balanceDue: json["balance_due"]?.toString() ?? "0",
    paidAt: json["paid_at"] != null ? DateTime.parse(json["paid_at"]) : null,
    details: json["details"] != null
        ? List<TransactionDetail>.from(
            json["details"].map((x) => TransactionDetail.fromJson(x)),
          )
        : json["detail_transaction"] != null
        ? List<TransactionDetail>.from(
            json["detail_transaction"].map(
              (x) => TransactionDetail.fromJson(x),
            ),
          )
        : [],
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

  // Convert Transaction to PaymentTransaction for dialog
  PaymentTransaction toPaymentTransaction() {
    return PaymentTransaction(
      id: transactionId,
      transactionId: transactionId,
      orderNo: orderNo,
      createdAt: createdAt,
      updatedAt: updatedAt,
      tableNo: tableNo,
      customerName: customerName,
      noTable: tableNo,
      userId: userId,
      serviceType: serviceType,
      status: status,
      allocatedAmount: grandTotal,
      grandTotal: grandTotal,
      paidTotal: paidTotal,
      balanceDue: balanceDue,
      paidAt: paidAt,
      detailTransaction: details
          .map(
            (d) => PaymentTransactionDetail(
              id: d.id,
              productId: d.productId ?? 0,
              productName: d.productName,
              quantity: d.quantity,
              price: d.price,
              subtotal: d.subtotal,
              flavor: d.flavor,
              spicyLevel: d.spicyLevel,
              note: d.note,
            ),
          )
          .toList(),
    );
  }
}

// Universal Transaction Detail model
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
        id: json["id"] ?? 0,
        productId: json["product_id"],
        productName: json["product_name"]?.toString() ?? "",
        quantity: json["quantity"] ?? 0,
        flavor: json["flavor"]?.toString(),
        spicyLevel: json["spicy_level"]?.toString(),
        note: json["note"]?.toString(),
        price: json["price"]?.toString() ?? "0",
        subtotal: json["subtotal"]?.toString() ?? "0",
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

// Response classes menggunakan Transaction model
class TransactionResponse {
  final bool success;
  final String message;
  final List<Transaction> data;

  TransactionResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) =>
      TransactionResponse(
        success: json["success"] ?? false,
        message: json["message"]?.toString() ?? "",
        data: json["data"] != null
            ? List<Transaction>.from(
                json["data"].map((x) => Transaction.fromJson(x)),
              )
            : [],
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SingleTransactionResponse {
  final bool success;
  final String message;
  final Transaction data;

  SingleTransactionResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SingleTransactionResponse.fromJson(Map<String, dynamic> json) =>
      SingleTransactionResponse(
        success: json["success"] ?? false,
        message: json["message"]?.toString() ?? "",
        data: Transaction.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

// Additional response classes for history transactions
class AllTransactionModelResponse {
  final bool success;
  final String message;
  final List<Transaction> data;

  AllTransactionModelResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AllTransactionModelResponse.fromJson(Map<String, dynamic> json) =>
      AllTransactionModelResponse(
        success: json["success"] ?? false,
        message: json["message"]?.toString() ?? "",
        data: json["data"] != null
            ? List<Transaction>.from(
                json["data"].map((x) => Transaction.fromJson(x)),
              )
            : [],
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetByIdTransactionModelResponse {
  final bool success;
  final String message;
  final Transaction data;

  GetByIdTransactionModelResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetByIdTransactionModelResponse.fromJson(Map<String, dynamic> json) =>
      GetByIdTransactionModelResponse(
        success: json["success"] ?? false,
        message: json["message"]?.toString() ?? "",
        data: Transaction.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

// Helper functions for backward compatibility
TransactionResponse transactionResponseFromJson(String str) =>
    TransactionResponse.fromJson(json.decode(str));

String transactionResponseToJson(TransactionResponse data) =>
    json.encode(data.toJson());

SingleTransactionResponse singleTransactionResponseFromJson(String str) =>
    SingleTransactionResponse.fromJson(json.decode(str));
String singleTransactionResponseToJson(SingleTransactionResponse data) =>
    json.encode(data.toJson());
