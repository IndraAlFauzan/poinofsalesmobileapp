import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:posmobile/data/model/response/spicy_level_model_response.dart';
import 'package:posmobile/service/service.dart';

class SpicyLevelRepository {
  final ServiceHttpClient _serviceHttpClient;

  SpicyLevelRepository(this._serviceHttpClient);

  Future<Either<String, SpicyLevelModelResponse>> fetchSpicyLevels() async {
    try {
      final response = await _serviceHttpClient.get('spicy-levels');
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final spicyLevelResponse = SpicyLevelModelResponse.fromJson(
          jsonResponse,
        );
        return Right(spicyLevelResponse);
      } else {
        return Left("Gagal memuat data level pedas");
      }
    } catch (e) {
      return Left("Error: $e");
    }
  }
}
