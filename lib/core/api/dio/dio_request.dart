import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'dio_response.dart';

class DioRequest {
  final Dio _dio;
  bool isTestDio = false;

  DioRequest({Dio? dioMock}) : _dio = dioMock ?? Dio() {
    isTestDio = dioMock != null;

    _dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      sendTimeout: const Duration(seconds: 5),
    );
  }

  Future<Dioresponse> requestGET(
    String url,
    Map<String, dynamic> params,
  ) async {
    try {
      var response = await _dio.get(url, queryParameters: params);

      return handleResponse(response);
    } on DioException catch (e) {
      return handleErrorDio(e);
    } catch (e) {
      return handleErrorGeneral(e);
    }
  }

  Dioresponse handleResponse(Response response) {
    if (kDebugMode) {
      print('==================== TESTING DIO REQUEST ====================');
      print("Response Status Code: ${response.statusCode}");
      print("Response Status Message: ${response.statusMessage}");
      print("Response Data: ${response.data}");
      print('==================== TESTING DIO REQUEST ====================\n');
    }

    bool error = response.statusCode != 200;
    String message = response.statusCode == 200
        ? "OK"
        : response.statusMessage ?? "Unknown Error";
    int code = response.statusCode == 200 ? 1 : 0;
    Map<String, dynamic> data = response.statusCode == 200 ? response.data : [];

    return Dioresponse(error: error, message: message, code: code, data: data);
  }

  Dioresponse handleErrorDio(DioException e) {
    if (kDebugMode) {
      print('==================== TESTING DIO REQUEST ====================');
      print("Dio Error: ${e.message}");
      print('==================== TESTING DIO REQUEST ====================\n');
    }

    return Dioresponse(
      error: true,
      message: e.message ?? "Unknown Error",
      code: 0,
      data: {},
    );
  }

  Dioresponse handleErrorGeneral(Object e) {
    if (kDebugMode) {
      print('==================== TESTING DIO REQUEST ====================');
      print("General Error: $e");
      print('==================== TESTING DIO REQUEST ====================\n');
    }

    return Dioresponse(error: true, message: e.toString(), code: 0, data: {});
  }
}
