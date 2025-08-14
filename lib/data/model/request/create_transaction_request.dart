import 'dart:convert';

CreateTransactionRequest createTransactionRequestFromJson(String str) =>
    CreateTransactionRequest.fromJson(json.decode(str));

String createTransactionRequestToJson(CreateTransactionRequest data) =>
    json.encode(data.toJson());

class CreateTransactionRequest {
  final int tableId;
  final String customerName;
  final int userId;
  final String serviceType;
  final List<TransactionDetail> details;

  CreateTransactionRequest({
    required this.tableId,
    required this.customerName,
    required this.userId,
    required this.serviceType,
    required this.details,
  });

  factory CreateTransactionRequest.fromJson(Map<String, dynamic> json) =>
      CreateTransactionRequest(
        tableId: json["table_id"],
        customerName: json["customer_name"],
        userId: json["user_id"],
        serviceType: json["service_type"],
        details: List<TransactionDetail>.from(
          json["details"].map((x) => TransactionDetail.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "table_id": tableId,
    "customer_name": customerName,
    "user_id": userId,
    "service_type": serviceType,
    "details": List<dynamic>.from(details.map((x) => x.toJson())),
  };
}

class TransactionDetail {
  final int productId;
  final int quantity;
  final String? note;
  final int? flavorId;
  final int? spicyLevelId;

  TransactionDetail({
    required this.productId,
    required this.quantity,
    this.note,
    this.flavorId,
    this.spicyLevelId,
  });

  factory TransactionDetail.fromJson(Map<String, dynamic> json) =>
      TransactionDetail(
        productId: json["product_id"],
        quantity: json["quantity"],
        note: json["note"],
        flavorId: json["flavor_id"],
        spicyLevelId: json["spicy_level_id"],
      );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "quantity": quantity,
    if (note != null) "note": note,
    if (flavorId != null) "flavor_id": flavorId,
    if (spicyLevelId != null) "spicy_level_id": spicyLevelId,
  };
}
