import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:posmobile/data/model/response/product_model_response.dart';
import 'package:posmobile/service/service.dart';

class ProductRepository {
  final ServiceHttpClient _serviceHttpClient;

  ProductRepository(this._serviceHttpClient);

  Future<Either<String, ProductModelResponse>> fetchProduct() async {
    try {
      final response = await _serviceHttpClient.get('products');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final productResponse = ProductModelResponse.fromJson(jsonResponse);
        return Right(productResponse);
      } else {
        final jsonResponse = json.decode(response.body);
        return Left(jsonResponse['message']);
        //return Left(productResponse.message);
      }
    } catch (e) {
      return Left("Error: $e");
    }
  }
}
