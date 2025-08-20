import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posmobile/data/model/request/transaction_model_request.dart';
import 'package:posmobile/data/model/request/create_transaction_request.dart';
import 'package:posmobile/data/model/request/edit_transaction_request.dart';
import 'package:posmobile/data/model/response/transaction_model.dart';
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

  // New transaction management methods
  Future<Either<String, SingleTransactionResponse>> createTransaction(
    CreateTransactionRequest data,
  ) async {
    try {
      final response = await _serviceHttpClient.postWihToken(
        'transactions',
        data.toJson(),
      );

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        final transactionResponse = SingleTransactionResponse.fromJson(
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

  Future<Either<String, TransactionResponse>> editTransaction(
    int transactionId,
    EditTransactionRequest data,
  ) async {
    try {
      final response = await _serviceHttpClient.putWithToken(
        'transactions/$transactionId',
        data.toJson(),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final transactionResponse = TransactionResponse.fromJson(jsonResponse);
        return Right(transactionResponse);
      } else {
        final jsonResponse = json.decode(response.body);
        return Left(jsonResponse['message']);
      }
    } catch (e) {
      return Left('Error: $e');
    }
  }

  Future<Either<String, TransactionResponse>> fetchPendingTransactions() async {
    try {
      final response = await _serviceHttpClient.get('transactions');
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final transactionResponse = TransactionResponse.fromJson(jsonResponse);
        return Right(transactionResponse);
      } else {
        final jsonResponse = json.decode(response.body);
        return Left(jsonResponse['message']);
      }
    } catch (e) {
      return Left("Error: $e");
    }
  }

  Future<Either<String, AllTransactionModelResponse>>
  fetchAllTransactionsHistory() async {
    try {
      final response = await _serviceHttpClient.get('all-transactions');
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
