import 'dart:convert';

EditTransactionRequest editTransactionRequestFromJson(String str) =>
    EditTransactionRequest.fromJson(json.decode(str));

String editTransactionRequestToJson(EditTransactionRequest data) =>
    json.encode(data.toJson());

class EditTransactionRequest {
  final List<TransactionDetail> details;

  EditTransactionRequest({required this.details});

  factory EditTransactionRequest.fromJson(Map<String, dynamic> json) =>
      EditTransactionRequest(
        details: List<TransactionDetail>.from(
          json["details"].map((x) => TransactionDetail.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
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
