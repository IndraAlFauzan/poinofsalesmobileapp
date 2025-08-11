import 'dart:convert';
import 'dart:developer' as console;

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:posmobile/data/model/request/login_model_request.dart';
import 'package:posmobile/data/model/response/login_model_response.dart';
import 'package:posmobile/service/service.dart';

class AuthRepository {
  final ServiceHttpClient _serviceHttpClient;
  final secureStorage = FlutterSecureStorage();

  AuthRepository(this._serviceHttpClient);

  Future<Either<String, LoginModelResponse>> login(
    LoginModelRequest loginModelRequest,
  ) async {
    try {
      final response = await _serviceHttpClient.post("login", {
        "email": loginModelRequest.email,
        "password": loginModelRequest.password,
      });

      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final loginResponse = LoginModelResponse.fromJson(jsonResponse);
        await secureStorage.write(
          key: "authToken",
          value: loginResponse.data.accessToken,
        );
        console.log("authToken: ${loginResponse.data.accessToken}");
        return Right(loginResponse);
      } else {
        return Left("${jsonResponse['message']}");
      }
    } catch (e) {
      return Left("Failed to connect: $e");
    }
  }
}
