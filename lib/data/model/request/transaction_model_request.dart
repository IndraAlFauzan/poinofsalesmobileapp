// To parse this JSON data, do
//
//     final transactionModelRequest = transactionModelRequestFromJson(jsonString);

import 'dart:convert';

TransactionModelRequest transactionModelRequestFromJson(String str) =>
    TransactionModelRequest.fromJson(json.decode(str));

String transactionModelRequestToJson(TransactionModelRequest data) =>
    json.encode(data.toJson());

class TransactionModelRequest {
  int userId;
  int paymentMethodId;
  int paymentAmount;
  String serviceType;
  List<Detail> details;

  TransactionModelRequest({
    required this.userId,
    required this.paymentMethodId,
    required this.paymentAmount,
    required this.serviceType,
    required this.details,
  });

  factory TransactionModelRequest.fromJson(Map<String, dynamic> json) =>
      TransactionModelRequest(
        userId: json["user_id"],
        paymentMethodId: json["payment_method_id"],
        paymentAmount: json["payment_amount"],
        serviceType: json["service_type"],
        details: List<Detail>.from(
          json["details"].map((x) => Detail.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "payment_method_id": paymentMethodId,
    "payment_amount": paymentAmount,
    "service_type": serviceType,
    "details": List<dynamic>.from(details.map((x) => x.toJson())),
  };
}

class Detail {
  int productId;
  int quantity;
  String note;
  int? flavorId;
  int? spicyLevelId;

  Detail({
    required this.productId,
    required this.quantity,
    required this.note,
    required this.flavorId,
    required this.spicyLevelId,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    productId: json["product_id"],
    quantity: json["quantity"],
    note: json["note"],
    flavorId: json["flavor_id"],
    spicyLevelId: json["spicy_level_id"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "quantity": quantity,
    "note": note,
    "flavor_id": flavorId,
    "spicy_level_id": spicyLevelId,
  };
}
