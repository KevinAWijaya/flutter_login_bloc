import 'dart:convert';

import 'package:wisdom_pos_test/core/globals.dart' as globals;
import 'package:wisdom_pos_test/data/models/response/response_login.dart';
import 'package:wisdom_pos_test/data/services/api_client.dart';
import 'package:wisdom_pos_test/data/services/api_url.dart';

class AuthRepository {
  final ApiClient apiClient;

  AuthRepository({required this.apiClient});

  Future<ResponseLogin> login({
    required String username,
    required String password,
  }) async {
    try {
      String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
      final response = await apiClient.post(
        url: ApiUrl.login,
        headers: {
          'Authorization': basicAuth,
          'Accept': 'application/json',
        },
      );

      if (response == null) {
        throw Exception("No response from server");
      }

      if (response.statusCode == 200) {
        final data = response.data;

        final responseLogin = ResponseLogin.fromJson(data);
        globals.accessToken = responseLogin.result!.accesstoken;

        return responseLogin;
      } else {
        throw Exception(response.data?['message'] ?? "Login failed");
      }
    } catch (e) {
      throw Exception("Login failed");
    }
  }
}
