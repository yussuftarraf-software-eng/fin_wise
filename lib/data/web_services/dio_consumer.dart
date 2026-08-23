import 'package:dio/dio.dart';
import 'package:fin_wise/data/web_services/api_consumer.dart';
import 'package:fin_wise/data/web_services/api_exception.dart';

import '../model/error_model.dart';
import 'endpoints_and_apikeys.dart';

class DioConsumer implements ApiConsumer {
  final Dio _dio = Dio(BaseOptions(baseUrl: Endpoints().baseUrl));

  @override
  Future<dynamic> get(
    String path,
    Object? data, {
    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await _dio.get(path, data: data, queryParameters: query);
      return response.data;
    } on DioException catch (e) {
      handleError(e);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<dynamic> delete(
    String path,
    Object? data, {
    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: query,
      );
      return response.data;
    } on DioException catch (e) {
      handleError(e);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<dynamic> post(
    String path,
    Object? data, {
    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: query,
      );
      return response.data;
    } on DioException catch (e) {
      handleError(e);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<dynamic> put(
    String path,
    Object? data, {
    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await _dio.put(path, data: data, queryParameters: query);
      return response.data;
    } on DioException catch (e) {
      handleError(e);
    } catch (e) {
      print(e.toString());
    }
  }
}

Future<void> main() async {
  DioConsumer dioConsumer = DioConsumer();
  try {
    final response = await dioConsumer.get("", null);
    print(response);
  } on DioException catch (e) {
    throw ApiException(error: ErrorModel(message: e.response?.data));
  }
}
