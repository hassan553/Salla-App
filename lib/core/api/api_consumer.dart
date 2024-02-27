import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:store_app/core/api/api_constants.dart';

class ApiClient {
  ApiClient._();
  static ApiClient? _instance;

  static ApiClient get instance {
    _instance ??= ApiClient._();
    return _instance!;
  }

 static Future<http.Response> getData(
    String path, {
    Map<String, String>? headers,
  }) async {
    final response = await _sendRequest(() => http.get(
          Uri.parse(path),
          headers: headers ?? {'Content-Type': 'application/json'},
        ));
    return  response;
  }

static Future<http.Response> postData(
    String path, {
    dynamic data,
    Map<String, String>? headers,
  }) async {
    final response = await _sendRequest(() => http.post(
          Uri.parse(path),
          headers: headers ?? {'Content-Type': 'application/json'},
          body: json.encode(data),
        ));

    return response;
  }

  

  static Future<http.Response> _sendRequest(
      Future<http.Response> Function() request) async {
    try {
      final response = await request();

      if (response.statusCode == 401) {
        final refreshedToken = await _refreshToken();
        final newResponse = await request();
        return newResponse;
      }

      return response;
    } on http.ClientException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> _refreshToken() async {
    final refreshResponse = await http.post(
      Uri.parse('https://example.com/refresh_token'),
      body: {'refresh_token': 'your_refresh_token'},
    );

    if (refreshResponse.statusCode == 200) {
      final newToken = json.decode(refreshResponse.body)['access_token'];
      final t = newToken;
      return newToken;
    } else {
      throw "error";
    }
  }
}

Future<String> handleError(http.Response response) async {
  // Customize error handling based on HTTP status codes
  return 'API Error: ${response.statusCode}';
}
