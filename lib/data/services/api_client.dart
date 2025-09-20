import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:wisdom_pos_test/data/services/dio_module.dart';

class ApiClient {
  final Dio _dioModule = DioModule.instance.service();

  Future<Response?> get(
      {required String url,
      Map<String, String> params = const {},
      Function(dynamic, dynamic)? onReceiveProgress,
      Map<String, dynamic> headers = const {}}) async {
    debugPrint("[ GET Request ]: $url");
    debugPrint("[ Params ]: $params");

    try {
      Response response = await _dioModule.get(url,
          queryParameters: params,
          options: Options(
            headers: headers,
          ),
          onReceiveProgress: onReceiveProgress);
      debugPrint("[ StatusCode ]: ${response.statusCode}");
      debugPrint("[ Data ]: ${response.data}");
      return response;
    } on DioException catch (e) {
      debugPrint("[ Error ${e.response?.statusCode ?? 503}]: ${e.response}");
      return e.response;
    }
  }

  Future<Response?> getWithDioNewInstance({required String url, Map<String, String> params = const {}, Map<String, dynamic> headers = const {}}) async {
    debugPrint("[ GET Request ]: $url");
    debugPrint("[ Params ]: $params");

    try {
      Response response = await Dio().get(url, queryParameters: params, options: Options(headers: headers));

      debugPrint("[ StatusCode ]: ${response.statusCode}");

      return response;
    } on DioException catch (e) {
      debugPrint("[ Error ${e.response?.statusCode ?? 503}]: ${e.response}");

      return e.response;
    }
  }

  Future<Response?> postMultipart({
    required String url,
    Map<String, dynamic> headers = const {},
    FormData? formData,
  }) async {
    try {
      headers[Headers.contentTypeHeader] = "multipart/form-data";

      debugPrint("[ PUT Multipart Request ]: $url");
      debugPrint("[ FormData ]: $formData");

      Response response = await _dioModule.post(url, options: Options(headers: headers), data: formData);

      debugPrint("[ StatusCode ]: ${response.statusCode}");

      return response;
    } on DioException catch (e) {
      debugPrint("[ Error ${e.response?.statusCode ?? 503}]: ${e.response}");

      return e.response;
    }
  }

  Future<Response?> putMultipart({
    required String url,
    Map<String, dynamic> headers = const {},
    FormData? formData,
  }) async {
    try {
      headers[Headers.contentTypeHeader] = "multipart/form-data";

      debugPrint("[ PUT Multipart Request ]: $url");
      debugPrint("[ FormData ]: $formData");

      Response response = await _dioModule.put(url, options: Options(headers: headers), data: formData);

      debugPrint("[ StatusCode ]: ${response.statusCode}");

      return response;
    } on DioException catch (e) {
      debugPrint("[ Error ${e.response?.statusCode ?? 503}]: ${e.response}");

      return e.response;
    }
  }

  Future<Response?> post({required String url, Map<String, dynamic> headers = const {}, dynamic body = const {}}) async {
    // headers["Content-Type"] =  Headers.jsonContentType;

    debugPrint("[ POST Request ]: $url");
    debugPrint("[ Body ]: $body");

    try {
      Response response = await _dioModule.post(url, options: Options(headers: headers), data: body);

      debugPrint("[ StatusCode ]: ${response.statusCode}");

      return response;
    } on DioException catch (e) {
      debugPrint("[ Error ${e.response?.statusCode ?? 503}]: ${e.response}");

      return e.response;
    }
  }

  Future<Response?> put({
    required String url,
    Map<String, dynamic> headers = const {},
    Map<String, String> params = const {},
    dynamic body = const {},
  }) async {
    // headers["Content-Type"] =  Headers.jsonContentType;

    debugPrint("[ PUT Request ]: $url");
    debugPrint("[ Body ]: $body");

    try {
      Response response = await _dioModule.put(
        url,
        queryParameters: params,
        options: Options(headers: headers),
        data: body,
      );

      debugPrint("[ StatusCode ]: ${response.statusCode}");

      return response;
    } on DioException catch (e) {
      debugPrint("[ Error ${e.response?.statusCode ?? 503}]: ${e.response} - ${e.message}");

      Response? errorResponse;

      if (e.type == DioExceptionType.unknown) {
        errorResponse = Response(requestOptions: RequestOptions(), statusMessage: e.message, statusCode: 401);
      } else {
        errorResponse = Response(requestOptions: RequestOptions(), statusMessage: e.message, statusCode: 503);
      }

      return errorResponse;
    }
  }

  Future<Response?> delete({required String url, Map<String, dynamic> headers = const {}, dynamic body = const {}}) async {
    // headers["Content-Type"] =  Headers.jsonContentType;

    debugPrint("[ DELETE Request ]: $url");
    debugPrint("[ Body ]: $body");

    try {
      Response response = await _dioModule.delete(url, options: Options(headers: headers), data: body);

      debugPrint("[ StatusCode ]: ${response.statusCode}");

      return response;
    } on DioException catch (e) {
      debugPrint("[ Error ${e.response?.statusCode ?? 503}]: ${e.response}");

      return e.response;
    }
  }

  Future<Map<String, dynamic>> download({
    required String url,
    required String fileDestination,
    Map<String, dynamic> headers = const {},
    Function(dynamic, dynamic)? onReceiveProgress,
    Map<String, dynamic> body = const {},
  }) async {
    // headers["Content-Type"] =  Headers.jsonContentType;

    debugPrint("[ DOWNLOAD Request ]: $url");
    debugPrint("[ Body ]: $body");

    try {
      Response response = await _dioModule.download(url, fileDestination,
          options: Options(
            headers: headers,
          ),
          onReceiveProgress: onReceiveProgress,
          data: body);

      debugPrint("[ StatusCode ]: ${response.statusCode}");
      debugPrint("[ OnReceiveProgress ]: $onReceiveProgress");

      return {
        "code": response.statusCode ?? 503,
        "messages": response.statusMessage ?? "Internal Server Error",
      };
    } on DioException catch (e) {
      debugPrint("[ Error ${e.response?.statusCode ?? 503}]: ${e.response}");

      return {
        "code": e.response!.statusCode ?? 503,
        "messages": e.response!.statusMessage ?? "Internal Server Error",
      };
    }
  }

  Map<String, dynamic> responseHandler(Response? res) {
    String message = "something_wrong";
    if (res == null && res?.data is String) {
      message = "something_wrong";
      res?.data = null;
    } else {
      debugPrint(res?.data.toString());

      if (res?.data['messages'] == null) {
        message = "Register Succes";
      } else {
        message = res?.data['messages'][0] ?? "something_wrong";
      }
    }

    return {
      "code": res?.statusCode ?? 503,
      "messages": message,
      "data": res?.data != null ? res!.data["data"] : null,
    };
  }
}
