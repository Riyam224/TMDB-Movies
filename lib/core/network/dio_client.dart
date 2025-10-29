import 'package:dio/dio.dart';
import 'package:movies_app/core/constants/api_constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: MyConstants.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer ${MyConstants.bearerToken}',
        },
      ),
    );

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        compact: true,
        maxWidth: 90,
      ),
    );

    return dio;
  }
}
