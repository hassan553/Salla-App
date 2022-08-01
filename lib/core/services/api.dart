import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:store_app/constants/api_url.dart';

class API {
  Future getProductSData() async {
    var data;
    try {
      http.Response response = await http.get(productUrl, headers: {
        'lang': 'en',
      });
      data = jsonDecode(response.body);
    } catch (onError) {
      print(onError.toString());
    }
    return data;
  }

  Future getCategoriesData() async {
    var data;
    try {
      http.Response response = await http.get(categoryUrl, headers: {
        'lang': 'en',
      });

      data = jsonDecode(response.body);
    } catch (onError) {
      print(onError.toString());
    }
    return data;
  }

  Future userLogin({email, password}) async {
    try {
      http.Response response = await http.post(
        loginUrl,
        body: json.encode(
          {
            "email": email,
            "password": password,
          },
        ),
        headers: {
          'lang': 'ar',
          'Content-Type': 'application/json',
        },
      );
      return jsonDecode(response.body);
    } catch (error) {
      print(error.toString());
    }
  }

  Future userRegister({
    var name,
    var phone,
    var password,
    var email,
  }) async {
    try {
      var response = await http.post(
        registerUrl,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'phone': phone,
            'name': name,
          },
        ),
      );
      return jsonDecode(response.body);
    } catch (error) {
      print(error.toString());
    }
  }
}
