import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posmobile/data/model/request/transaction_model_request.dart';
import 'package:posmobile/data/model/response/transaction_mode_response.dart';
import 'package:posmobile/service/service.dart';

class TransactionRepository {
  final ServiceHttpClient _serviceHttpClient;

  TransactionRepository(this._serviceHttpClient);

  Future<Either<String, GetByIdTransactionModelResponse>> submitTransaction(
    TransactionModelRequest data,
  ) async {
    try {
      final response = await _serviceHttpClient.postWihToken(
        'transactions',
        data.toJson(),
      );

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        final transactionResponse = GetByIdTransactionModelResponse.fromJson(
          jsonResponse,
        );
        return Right(transactionResponse);
      } else {
        final jsonResponse = json.decode(response.body);
        return Left(jsonResponse['message']);
      }
    } catch (e) {
      return Left('Error: $e');
    }
  }

  Future<Either<String, AllTransactionModelResponse>>
  fetchAllTransactions() async {
    try {
      final response = await _serviceHttpClient.get('transactions');
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final transactionResponse = AllTransactionModelResponse.fromJson(
          jsonResponse,
        );
        return Right(transactionResponse);
      } else {
        final jsonResponse = json.decode(response.body);
        return Left(jsonResponse['message']);
      }
    } catch (e) {
      return Left("Error: $e");
    }
  }
}
