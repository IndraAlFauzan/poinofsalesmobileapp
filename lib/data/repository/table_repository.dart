import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:posmobile/data/model/response/table_response.dart';
import 'package:posmobile/service/service.dart';

class TableRepository {
  final ServiceHttpClient _serviceHttpClient;

  TableRepository(this._serviceHttpClient);

  Future<Either<String, TableResponse>> getTables() async {
    try {
      final response = await _serviceHttpClient.get('tables');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final tableResponse = TableResponse.fromJson(jsonResponse);
        return Right(tableResponse);
      } else {
        final jsonResponse = json.decode(response.body);
        return Left(jsonResponse['message'] ?? 'Failed to fetch tables');
      }
    } catch (e) {
      return Left("Error: $e");
    }
  }
}
