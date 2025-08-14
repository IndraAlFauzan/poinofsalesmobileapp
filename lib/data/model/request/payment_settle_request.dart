import 'dart:convert';

PaymentSettleRequest paymentSettleRequestFromJson(String str) =>
    PaymentSettleRequest.fromJson(json.decode(str));

String paymentSettleRequestToJson(PaymentSettleRequest data) =>
    json.encode(data.toJson());

class PaymentSettleRequest {
  final int paymentMethodId;
  final List<int> transactionIds;
  final double? tenderedAmount;
  final String? note;

  PaymentSettleRequest({
    required this.paymentMethodId,
    required this.transactionIds,
    this.tenderedAmount,
    this.note,
  });

  factory PaymentSettleRequest.fromJson(Map<String, dynamic> json) =>
      PaymentSettleRequest(
        paymentMethodId: json["payment_method_id"],
        transactionIds: List<int>.from(json["transaction_ids"].map((x) => x)),
        tenderedAmount: json["tendered_amount"] != null
            ? (json["tendered_amount"] is String
                  ? double.parse(json["tendered_amount"])
                  : (json["tendered_amount"] as num).toDouble())
            : null,
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
    "payment_method_id": paymentMethodId,
    "transaction_ids": List<dynamic>.from(transactionIds.map((x) => x)),
    if (tenderedAmount != null) "tendered_amount": tenderedAmount,
    if (note != null) "note": note,
  };
}
