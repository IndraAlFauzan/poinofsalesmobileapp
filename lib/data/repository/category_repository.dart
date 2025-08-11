import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posmobile/data/model/response/category_model_response.dart';
import 'package:posmobile/service/service.dart';

class CategoryRepository {
  final ServiceHttpClient _serviceHttpClient;

  CategoryRepository(this._serviceHttpClient);

  Future<Either<String, CategoryResponse>> fetchCategories() async {
    try {
      final response = await _serviceHttpClient.get('categories');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final categoryResponse = CategoryResponse.fromJson(jsonResponse);
        return Right(categoryResponse);
      } else {
        final jsonResponse = json.decode(response.body);
        return Left(jsonResponse['message']);
      }
    } catch (e) {
      return Left("Error: $e");
    }
  }
}
