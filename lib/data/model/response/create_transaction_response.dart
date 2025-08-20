import 'dart:convert';
import 'package:posmobile/data/model/response/transaction_response.dart';

CreateTransactionResponse createTransactionResponseFromJson(String str) =>
    CreateTransactionResponse.fromJson(json.decode(str));

String createTransactionResponseToJson(CreateTransactionResponse data) =>
    json.encode(data.toJson());

class CreateTransactionResponse {
  final bool success;
  final String message;
  final TransactionData data; // Single object, not array

  CreateTransactionResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CreateTransactionResponse.fromJson(Map<String, dynamic> json) =>
      CreateTransactionResponse(
        success: json["success"],
        message: json["message"],
        data: TransactionData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}
