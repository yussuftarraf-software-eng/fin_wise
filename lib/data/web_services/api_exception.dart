import 'package:dio/dio.dart';

import '../model/error_model.dart';

class ApiException implements Exception {
  final ErrorModel error;
  ApiException({required this.error});
}

int? handleError(DioException e) {
  print(e.response?.data);

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.transformTimeout:
      throw ApiException(error: ErrorModel(message: e.response?.data));

    case DioExceptionType.cancel:
      throw ApiException(error: ErrorModel(message: e.response?.data));

    case DioExceptionType.connectionError:
      throw ApiException(error: ErrorModel(message: e.response?.data));

    case DioExceptionType.badCertificate:
    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        default:
          return e.response?.statusCode;
      }

    case DioExceptionType.unknown:
      throw ApiException(error: ErrorModel(message: e.response?.data));
  }
}
