import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posmobile/data/model/response/payment_method_model_response.dart';
import 'package:posmobile/service/service.dart';

class PaymentMethodRepository {
  final ServiceHttpClient _serviceHttpClient;

  PaymentMethodRepository(this._serviceHttpClient);

  Future<Either<String, PaymentMethodModelResponse>> fetchPayment() async {
    try {
      final response = await _serviceHttpClient.get('payment-methods');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final paymentResponse = PaymentMethodModelResponse.fromJson(
          jsonResponse,
        );
        return Right(paymentResponse);
      } else {
        final jsonResponse = json.decode(response.body);
        return Left(jsonResponse['message']);
      }
    } catch (e) {
      return Left("Error: $e");
    }
  }
}
