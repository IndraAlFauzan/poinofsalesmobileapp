import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posmobile/data/model/request/payment_settle_request.dart';
import 'package:posmobile/data/model/response/payment_response.dart';
import 'package:posmobile/data/model/response/payment_single_response.dart';
import 'package:posmobile/service/service.dart';

class PaymentRepository {
  final ServiceHttpClient _serviceHttpClient;

  PaymentRepository(this._serviceHttpClient);

  Future<Either<String, PaymentsResponse>> fetchPayments() async {
    try {
      final response = await _serviceHttpClient.get('payments');
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final paymentsResponse = PaymentsResponse.fromJson(jsonResponse);
        return Right(paymentsResponse);
      } else {
        final jsonResponse = json.decode(response.body);
        return Left(jsonResponse['message']);
      }
    } catch (e) {
      return Left("Error: $e");
    }
  }

  Future<Either<String, PaymentSettleResponse>> settlePayment(
    PaymentSettleRequest data,
  ) async {
    try {
      final response = await _serviceHttpClient.postWihToken(
        'payment-settle',
        data.toJson(),
      );

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        final paymentResponse = PaymentSettleResponse.fromJson(jsonResponse);
        return Right(paymentResponse);
      } else {
        final jsonResponse = json.decode(response.body);
        return Left(jsonResponse['message']);
      }
    } catch (e) {
      return Left('Error: $e');
    }
  }

  // Get single payment by ID for polling
  Future<Either<String, PaymentSingleResponse>> getPaymentById(
    int paymentId,
  ) async {
    try {
      print('[PaymentRepo] Getting payment by ID: $paymentId');
      final response = await _serviceHttpClient.get('payments/$paymentId');
      print('[PaymentRepo] Response status: ${response.statusCode}');
      print('[PaymentRepo] Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final paymentResponse = PaymentSingleResponse.fromJson(jsonResponse);
        print('[PaymentRepo] Payment status: ${paymentResponse.data.status}');
        return Right(paymentResponse);
      } else {
        final jsonResponse = json.decode(response.body);
        final errorMessage = jsonResponse['message'] ?? 'Unknown error';
        print('[PaymentRepo] Error: $errorMessage');
        return Left(errorMessage);
      }
    } catch (e) {
      print('[PaymentRepo] Exception: $e');
      return Left("Error: $e");
    }
  }

  // Retry payment
  Future<Either<String, PaymentRetryResponse>> retryPayment(
    int paymentId,
  ) async {
    try {
      final response = await _serviceHttpClient.postWihToken(
        'payments/$paymentId/retry',
        {},
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final retryResponse = PaymentRetryResponse.fromJson(jsonResponse);
        return Right(retryResponse);
      } else {
        final jsonResponse = json.decode(response.body);
        return Left(jsonResponse['message']);
      }
    } catch (e) {
      return Left('Error: $e');
    }
  }

  // Cancel payment
  Future<Either<String, PaymentCancelResponse>> cancelPayment(
    int paymentId,
  ) async {
    try {
      final response = await _serviceHttpClient.postWihToken(
        'payments/$paymentId/cancel',
        {},
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final cancelResponse = PaymentCancelResponse.fromJson(jsonResponse);
        return Right(cancelResponse);
      } else {
        final jsonResponse = json.decode(response.body);
        return Left(jsonResponse['message']);
      }
    } catch (e) {
      return Left('Error: $e');
    }
  }
}
