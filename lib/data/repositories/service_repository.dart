import 'package:wisdom_pos_test/core/globals.dart' as globals;
import 'package:wisdom_pos_test/data/models/response/data_service.dart';
import 'package:wisdom_pos_test/data/models/service.dart';
import 'package:wisdom_pos_test/data/services/api_client.dart';
import 'package:wisdom_pos_test/data/services/api_url.dart';

class ServiceRepository {
  final ApiClient apiClient;

  ServiceRepository({required this.apiClient});

  Future<List<Service>> fetchServices() async {
    final response = await apiClient.get(
      url: ApiUrl.getService,
      headers: {
        'Authorization': 'Bearer ${globals.accessToken}',
        'Content-Type': 'application/json',
      },
    );

    if (response == null) {
      throw Exception("No response from server");
    }

    if (response.statusCode == 200) {
      final responseLogin = ResponseDataService.fromJson(response.data);

      return responseLogin.result!.service ?? [];
    } else {
      throw Exception('Failed to load services: ${response.statusCode}');
    }
  }
}
