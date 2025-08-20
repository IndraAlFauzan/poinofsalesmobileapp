import 'dart:convert';
import 'payment_response.dart';

// For GET /payments/{id} - Single payment response
PaymentSingleResponse paymentSingleResponseFromJson(String str) =>
    PaymentSingleResponse.fromJson(json.decode(str));

String paymentSingleResponseToJson(PaymentSingleResponse data) =>
    json.encode(data.toJson());

class PaymentSingleResponse {
  final bool success;
  final String message;
  final PaymentData data;

  PaymentSingleResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PaymentSingleResponse.fromJson(Map<String, dynamic> json) =>
      PaymentSingleResponse(
        success: json["success"],
        message: json["message"],
        data: PaymentData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

// For POST /payments/{id}/retry - Retry payment response
PaymentRetryResponse paymentRetryResponseFromJson(String str) =>
    PaymentRetryResponse.fromJson(json.decode(str));

String paymentRetryResponseToJson(PaymentRetryResponse data) =>
    json.encode(data.toJson());

class PaymentRetryResponse {
  final bool success;
  final String message;
  final String checkoutUrl;
  final PaymentData data;

  PaymentRetryResponse({
    required this.success,
    required this.message,
    required this.checkoutUrl,
    required this.data,
  });

  factory PaymentRetryResponse.fromJson(Map<String, dynamic> json) =>
      PaymentRetryResponse(
        success: json["success"],
        message: json["message"],
        checkoutUrl: json["checkout_url"],
        data: PaymentData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "checkout_url": checkoutUrl,
    "data": data.toJson(),
  };
}

// For POST /payments/{id}/cancel - Cancel payment response
PaymentCancelResponse paymentCancelResponseFromJson(String str) =>
    PaymentCancelResponse.fromJson(json.decode(str));

String paymentCancelResponseToJson(PaymentCancelResponse data) =>
    json.encode(data.toJson());

class PaymentCancelResponse {
  final bool success;
  final String message;
  final PaymentData data;

  PaymentCancelResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PaymentCancelResponse.fromJson(Map<String, dynamic> json) =>
      PaymentCancelResponse(
        success: json["success"],
        message: json["message"],
        data: PaymentData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}
