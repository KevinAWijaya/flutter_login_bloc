import 'package:dio/dio.dart';

class DioModule {
  final Dio _dio = Dio();

  DioModule._privateConstructor();

  static final DioModule instance = DioModule._privateConstructor();

  Dio service() {
    return _dio;
  }
}
