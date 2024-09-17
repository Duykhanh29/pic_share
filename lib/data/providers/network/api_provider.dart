import 'dart:async';
import 'dart:io';
import 'package:get/get.dart' as g;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pic_share/app/services/token_manager.dart';
import 'package:pic_share/app/helper/snack_bar_helper.dart';
import 'package:pic_share/data/providers/network/api_request_representable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class APIProvider {
  late Dio _dio;
  static final APIProvider _instance = APIProvider._internal();
  factory APIProvider() => _instance;
  APIProvider._internal() {
    _dio = Dio();
    _dio.options.receiveTimeout = const Duration(minutes: 2);
    _dio.options.headers[HttpHeaders.contentTypeHeader] = 'application/json';
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
        // Retrieve the access token from storage
        String? accessToken = await TokenManager().getToken();
        if (accessToken != null && accessToken.isNotEmpty) {
          // Add the access token to the headers
          options.headers[HttpHeaders.authorizationHeader] =
              'Bearer $accessToken';
        }
        return handler.next(options);
      },
      onError: (e, handler) async {
        if (e.response?.statusCode == 401) {}
        if (e.response?.statusCode == 403) {}
        return handler.next(e);
      },
    ));
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: false,
      responseHeader: false,
      compact: true,
    ));
  }
  Dio get instance => _dio;

  Future<dynamic> request<T extends dynamic>(
      APIRequestRepresentable request) async {
    try {
      final Response<T> response = await _dio.request(
        request.url,
        options:
            Options(method: request.method.string, headers: request.headers),
        queryParameters: request.query,
        data: request.body,
        onReceiveProgress: (val1, val2) {
          debugPrint("WHAT HAPPEND: $val1, $val2");
        },
        onSendProgress: (val1, val2) {
          debugPrint("WHAT HAPPEND: $val1, $val2");
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
      return null;
    } on TimeoutException catch (_) {
      throw DioException.sendTimeout(
          timeout: const Duration(seconds: 25),
          requestOptions: RequestOptions());
    } on SocketException {
      throw DioException.connectionError(
        requestOptions: RequestOptions(),
        reason: 'Network is not available',
      );
    } on DioException catch (e) {
      final message = e.response?.data['message'];
      if (g.Get.isSnackbarOpen == false) {
        SnackbarHelper.errorSnackbar(message);
      }
      debugPrint("Something went wrong: ${e.toString()}");
    } catch (e) {
      rethrow;
    }
  }
}
