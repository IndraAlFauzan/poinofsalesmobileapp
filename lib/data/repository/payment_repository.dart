import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posmobile/data/model/request/payment_settle_request.dart';
import 'package:posmobile/data/model/response/payment_response.dart';
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
}
