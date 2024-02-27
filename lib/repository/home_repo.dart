import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:store_app/models/category_model.dart';
import '../core/api/api_constants.dart';
import '../core/api/api_consumer.dart';
import '../core/api/error.dart';
import '../models/product_model.dart';

class HomeRepo {
  Future<Either<Failure, ProductModel>> getProductSData() async {
    try {
      Response response = await ApiClient.getData(
        ApiEndPoints.productsUrl,
        headers: {'lang': 'ar', 'Content-Type': 'application/json'},
      );
      ProductModel productModel =
          ProductModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        return right(productModel);
      } else {
        return left(ServerFailure.fromResponse(
            message: 'Server Failure', statusCode: response.statusCode));
      }
    } catch (error) {
      return left(ServerFailure(error.toString()));
    }
  }

  Future<Either<Failure, CategoriesModel>> getCategoriesData() async {
    try {
      Response response = await ApiClient.getData(
        ApiEndPoints.categoryUrl,
        headers: {'lang': 'ar', 'Content-Type': 'application/json'},
      );
      CategoriesModel categoriesModel =
          CategoriesModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        return right(categoriesModel);
      } else {
        return left(ServerFailure.fromResponse(
            message: 'Server Failure', statusCode: response.statusCode));
      }
    } catch (error) {
      return left(ServerFailure(error.toString()));
    }
  }
}
