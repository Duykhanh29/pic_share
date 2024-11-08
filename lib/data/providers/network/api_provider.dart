import 'dart:async';
import 'dart:io';
import 'package:get/get.dart' as g;
import 'package:dio/dio.dart';
import 'package:pic_share/app/services/local_storage_service.dart';
import 'package:pic_share/app/services/token_manager.dart';
import 'package:pic_share/app/helper/snack_bar_helper.dart';
import 'package:pic_share/data/providers/network/api_request_representable.dart';
import 'package:pic_share/data/providers/network/api_response.dart';
import 'package:pic_share/routes/app_pages.dart';
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
        if (e.response?.statusCode == 403) {
          SnackbarHelper.errorSnackbar(
              e.response?.statusMessage ?? "This account has been banned");
        }
        if (e.response?.statusCode == 303) {
          return handleRedirect();
        }
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

  Future<ApiResponse<T>> request<T>(APIRequestRepresentable<T> request) async {
    try {
      print("The type of T is: ${T.toString()}");
      print("Type of request.fromJson: ${request.fromJson.runtimeType}");
      print("request url: ${request.url}");
      final Response response = await _dio.request(
        request.url,
        options:
            Options(method: request.method.string, headers: request.headers),
        queryParameters: request.query,
        data: request.body,
        onReceiveProgress: (val1, val2) {},
        onSendProgress: (val1, val2) {},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Response DATA: ${response.data.toString()}");
        final apiResponse = ApiResponse.fromJson(
            response.data as Map<String, dynamic>, request.fromJson);
        return apiResponse;
      } else if (response.statusCode == 403) {
        SnackbarHelper.errorSnackbar(
            response.statusMessage ?? "This account has been banned");
      }
      return ApiResponse(
          status: ApiStatus.failure, message: response.statusMessage);
    } on TimeoutException catch (_) {
      return ApiResponse(
        status: ApiStatus.failure,
      );
      // throw DioException.sendTimeout(
      //     timeout: const Duration(seconds: 25),
      //     requestOptions: RequestOptions());
    } on SocketException {
      return ApiResponse(
        status: ApiStatus.failure,
      );
      // throw DioException.connectionError(
      //   requestOptions: RequestOptions(),
      //   reason: 'Network is not available',
      // );
    } on DioException catch (e) {
      print("DioException caught: ${e.toString()}");
      final message = e.response?.data['message'];
      // if (g.Get.isSnackbarOpen == false) {
      //   SnackbarHelper.errorSnackbar(message);
      // }
      return ApiResponse(status: ApiStatus.failure, message: message);
      // debugPrint("Something went wrong: ${e.toString()}");
    } catch (e) {
      return ApiResponse(status: ApiStatus.failure, message: e.toString());
      // rethrow;
    }
  }

  Future<void> handleRedirect() async {
    try {
      await deleteSession();
      g.Get.offAllNamed(Routes.login);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteSession() async {
    LocalStorageService localStorageService = g.Get.find<LocalStorageService>();
    localStorageService.removeAllSharedPreferencesValues();
    await TokenManager().deleteAll();
  }
}
