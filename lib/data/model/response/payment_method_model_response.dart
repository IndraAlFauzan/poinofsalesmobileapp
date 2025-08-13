import 'dart:convert';

PaymentMethodModelResponse paymentMethodModelResponseFromJson(String str) =>
    PaymentMethodModelResponse.fromJson(json.decode(str));

String paymentMethodModelResponseToJson(PaymentMethodModelResponse data) =>
    json.encode(data.toJson());

class PaymentMethodModelResponse {
  bool success;
  String message;
  List<Payment> data;

  PaymentMethodModelResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PaymentMethodModelResponse.fromJson(Map<String, dynamic> json) =>
      PaymentMethodModelResponse(
        success: json["success"],
        message: json["message"],
        data: List<Payment>.from(json["data"].map((x) => Payment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Payment {
  int id;
  String name;

  Payment({required this.id, required this.name});

  factory Payment.fromJson(Map<String, dynamic> json) =>
      Payment(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
