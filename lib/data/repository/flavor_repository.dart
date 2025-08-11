import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:posmobile/data/model/response/flavor_model_response.dart';
import 'package:posmobile/service/service.dart';

class FlavorRepository {
  final ServiceHttpClient _serviceHttpClient;

  FlavorRepository(this._serviceHttpClient);

  Future<Either<String, FlavorsModelResnponse>> fetchFlavors() async {
    try {
      final response = await _serviceHttpClient.get('flavors');
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final flavoreResponse = FlavorsModelResnponse.fromJson(jsonResponse);
        return Right(flavoreResponse);
      } else {
        return Left("Gagal memuat data rasa");
      }
    } catch (e) {
      return Left("Error: $e");
    }
  }
}
