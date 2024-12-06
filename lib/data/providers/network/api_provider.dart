import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as g;
import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pic_share/app/services/local_storage_service.dart';
import 'package:pic_share/app/services/pusher_service.dart';
import 'package:pic_share/app/services/token_manager.dart';
import 'package:pic_share/app/helper/snack_bar_helper.dart';
import 'package:pic_share/data/providers/network/api_request_representable.dart';
import 'package:pic_share/data/providers/network/api_response.dart';
import 'package:pic_share/data/repositories/auth/auth_repository.dart';
import 'package:pic_share/routes/app_pages.dart';
import 'package:pic_share/view_model/app/session_controller.dart';
import 'package:pic_share/view_model/friend/friend_controller.dart';
import 'package:pic_share/view_model/friend_profile/friend_profile_controller.dart';
import 'package:pic_share/view_model/home/home_controller.dart';
import 'package:pic_share/view_model/nav_bottom/nav_bottom_controller.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:pic_share/app/services/notification_service.dart';

class APIProvider {
  late Dio _dio;
  static final APIProvider _instance = APIProvider._internal();
  factory APIProvider() => _instance;
  APIProvider._internal() {
    _dio = Dio();
    _dio.options.receiveTimeout = const Duration(minutes: 1);
    _dio.options.headers[HttpHeaders.contentTypeHeader] = 'application/json';
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
        if (options.headers[HttpHeaders.authorizationHeader] == null) {
          // Retrieve the access token from storage
          String? accessToken = await TokenManager().getToken();
          if (accessToken != null && accessToken.isNotEmpty) {
            // Add the access token to the headers
            options.headers[HttpHeaders.authorizationHeader] =
                'Bearer $accessToken';
          }
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
        message: "Request time out",
      );
    } on SocketException catch (e) {
      return ApiResponse(
        status: ApiStatus.failure,
        message: "Network is not available: ${e.message}",
      );
    } on DioException catch (e, h) {
      final message = e.response?.data['message'] ?? e.error.toString();
      // if (g.Get.isSnackbarOpen == false) {
      //   SnackbarHelper.errorSnackbar(message);
      // }
      if (e.type == DioExceptionType.connectionError) {
        return ApiResponse(
          status: ApiStatus.failure,
          message: "Network is not available",
        );
      }
      if (e.response?.statusCode == 403) {
        SnackbarHelper.errorSnackbar(
            e.response?.statusMessage ?? "This account has been banned");
      } else if (e.response?.statusCode == 401) {
        return _handleUnauthorized<T>(e, h, request);
      }
      return ApiResponse(status: ApiStatus.failure, message: message);
    } catch (e) {
      return ApiResponse(status: ApiStatus.failure, message: e.toString());
    }
  }

  Future<ApiResponse<T>> unsafeCall<T>(
      APIRequestRepresentable<T> request) async {
    final Response response = await _dio.request(
      request.url,
      options: Options(method: request.method.string, headers: request.headers),
      queryParameters: request.query,
      data: request.body,
      onReceiveProgress: (val1, val2) {},
      onSendProgress: (val1, val2) {},
    );
    return ApiResponse.fromJson(
      response.data as Map<String, dynamic>,
      request.fromJson,
    );
  }

  Future<void> handleRedirect() async {
    try {
      if (g.Get.currentRoute != Routes.login) {
        await deleteSession();
        g.Get.offAllNamed(Routes.login);
        resetIndexes();
        deleteFcmToken();
      }
    } catch (e) {
      rethrow;
    }
  }

  void setToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  Future<ApiResponse<T>> _handleUnauthorized<T>(
      DioException e, handler, APIRequestRepresentable<T> request) async {
    try {
      await TokenManager().deleteAccessToken();
      String? refreshToken = await TokenManager().getRefreshToken();
      if (refreshToken != null) {
        final accessToken = await refreshAccessToken(refreshToken);
        if (accessToken != null) {
          await setNewAccessToken(accessToken);
          final newRequest = e.requestOptions;
          newRequest.headers["Authorization"] = "Bearer $accessToken";
          return this.request<T>(request);
          /*
        final response = await _dio.fetch<Map<String, dynamic>>(newRequest);
        
        final apiResponse = ApiResponse.fromJson(response.data, request.fromJson);
        
        return handler.resolve(apiResponse);
          */
        }
      }
      handleRedirect();
    } catch (e) {
      handleRedirect();
    }
    return _unauthorizedResponse(e);
  }

  ApiResponse<T> _unauthorizedResponse<T>(DioException e) {
    return ApiResponse(
      status: ApiStatus.failure,
      message:
          'Unauthorized: ${e.response?.data['message'] ?? 'Access denied'}',
    );
  }

  Future<String?> refreshAccessToken(String refreshToken) async {
    final authRepository = g.Get.find<AuthRepository>();
    // setToken(refreshToken);
    final response =
        await authRepository.refreshToken(refreshToken: refreshToken);
    return response.data;
  }

  Future<void> setNewAccessToken(String accessToken) async {
    await TokenManager().setAccessToken(accessToken);
    if (g.Get.isRegistered<SessionController>()) {
      final sessionController = g.Get.find<SessionController>();
      sessionController.fetchToken();
    }
  }

  Future<void> deleteSession() async {
    LocalStorageService localStorageService = g.Get.find<LocalStorageService>();
    localStorageService.removeAllSharedPreferencesValues();
    await TokenManager().deleteAll();
    deleteControllerDependenciesInjection();
  }

  Future<void> deleteFcmToken() async {
    final notificationService = g.Get.find<NotificationsService>();
    await notificationService.deleteCurrentToken();
  }

  void resetIndexes() {
    final isRegisteredNavBottom = Get.isRegistered<NavBottomController>();
    final isRegisteredHome = Get.isRegistered<HomeController>();
    final isRegisteredFriend = Get.isRegistered<FriendController>();
    final isRegisteredFriendProfile =
        Get.isRegistered<FriendProfileController>();
    if (isRegisteredNavBottom) {
      final navBottomController = Get.find<NavBottomController>();
      navBottomController.resetIndexes();
    }
    if (isRegisteredHome) {
      final homeController = Get.find<HomeController>();
      homeController.resetIndexes();
    }
    if (isRegisteredFriend) {
      final friendController = Get.find<FriendController>();
      friendController.resetToDefault();
    }
    if (isRegisteredFriendProfile) {
      final friendProfileController = Get.find<FriendProfileController>();
      friendProfileController.onResetTabIndex();
    }
  }

  Future<void> deleteControllerDependenciesInjection() async {
    try {
      await Get.delete<PusherService>();
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }
}
