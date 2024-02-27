import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:store_app/core/api/api_constants.dart';
import 'package:store_app/core/api/error.dart';

import '../core/api/api_consumer.dart';
import '../models/user_model.dart';

class AuthRepo {
  Future<Either<Failure, UserModel>> userLogin({email, password}) async {
    try {
      Response response = await ApiClient.postData(
        ApiEndPoints.loginUrl,
        data: json.encode(
          {"email": email, "password": password},
        ),
        headers: {'lang': 'ar', 'Content-Type': 'application/json'},
      );
      UserModel userModel = UserModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        return right(userModel);
      } else {
        return left(ServerFailure.fromResponse(
            message: userModel.message ?? '', statusCode: response.statusCode));
      }
    } catch (error) {
      return left(ServerFailure(error.toString()));
    }
  }

  Future<Either<Failure, UserModel>> userRegister(
      {var name, var phone, var password, var email}) async {
    try {
      Response response = await ApiClient.postData(
        ApiEndPoints.registerUrl,
        data: json.encode(
          {"email": email, "password": password, 'phone': phone, 'name': name},
        ),
        headers: {'lang': 'ar', 'Content-Type': 'application/json'},
      );
      UserModel userModel = UserModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        return right(userModel);
      } else {
        return left(ServerFailure.fromResponse(
            message: userModel.message ?? '', statusCode: response.statusCode));
      }
    } catch (error) {
      return left(ServerFailure(error.toString()));
    }
  }
}
