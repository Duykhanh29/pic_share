import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/helper/device_info_helper.dart';
import 'package:pic_share/app/helper/snack_bar_helper.dart';
import 'package:pic_share/app/services/local_storage_service.dart';
import 'package:pic_share/app/services/notification_service.dart';
import 'package:pic_share/app/services/token_manager.dart';
import 'package:pic_share/data/enums/role_type.dart';
import 'package:pic_share/data/models/user/user_model.dart';
import 'package:pic_share/data/providers/network/api_response.dart';
import 'package:pic_share/data/repositories/auth/auth_repository.dart';
import 'package:pic_share/data/repositories/user/user_repository.dart';
import 'package:pic_share/routes/app_pages.dart';
import 'package:pic_share/view_model/app/session_controller.dart';

class SignInController extends GetxController {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final LocalStorageService localStorageService;
  NotificationsService notificationsService;
  final SessionController sessionController;
  final _tokenManager = TokenManager();
  Rx<UserModel?> user = Rx<UserModel?>(null);
  SignInController({
    required this.authRepository,
    required this.userRepository,
    required this.localStorageService,
    required this.notificationsService,
    required this.sessionController,
  });
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  RxBool isPassVisibility = false.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // emailController = TextEditingController();
    // passController = TextEditingController();
    super.onInit();
  }

  void onChangePassVisibility() {
    isPassVisibility.value = !isPassVisibility.value;
  }

  Future<void> signInWithEmailPass() async {
    var isValid = formKey.currentState!.validate();
    if (isValid) {
      await handleApiCall(
        apiCall: () async {
          final deviceId = await DeviceInfoHelper.getDeviceId();
          final deviceName = await DeviceInfoHelper.getDeviceName();
          return await authRepository.signInWithEmailPass(
            email: emailController.text.trim(),
            password: passController.text,
            deviceId: deviceId,
            deviceName: deviceName,
          );
        },
        onSuccess: (response) async {
          user.value = response.data;
          if (user.value != null) {
            if (user.value!.roleType == RoleType.admin) {
              Get.toNamed(Routes.adminPage);
            } else {
              await _tokenManager.setAccessToken(user.value?.accessToken);
              await sessionController.fetchToken();
              if (user.value?.refreshToken != null) {
                await _tokenManager.setRefreshToken(user.value?.refreshToken);
                String? token = await notificationsService.getToken();
                if (token != null) {
                  debugPrint("TOken of FCM is: $token");
                  await userRepository.updateFcmToken(fcmToken: token);
                  user.value = user.value?.copyWith(
                      config: user.value?.config?.copyWith(fcmToken: token));
                }
                localStorageService.setUserModel(value: user.value);
              } else {
                Get.toNamed(Routes.check2Fa);
              }
            }
          }
        },
      );
    } else {
      debugPrint('form is not valid');
    }
  }

  Future<void> signInWithGoogle() async {
    await handleApiCall(
      apiCall: () async {
        return await authRepository.signInWithGoogle();
      },
      onSuccess: (response) async {
        user.value = response.data;
        await _tokenManager.setAccessToken(user.value?.accessToken);
        await _tokenManager.setRefreshToken(user.value?.refreshToken);
        await sessionController.fetchToken();
        String? token = await notificationsService.getToken();
        if (token != null) {
          await userRepository.updateFcmToken(fcmToken: token);
          user.value = user.value
              ?.copyWith(config: user.value?.config?.copyWith(fcmToken: token));
        }
        localStorageService.setUserModel(value: user.value);
      },
    );
  }

  Future<void> handleApiCall({
    required Future<ApiResponse> Function() apiCall,
    required Future<void> Function(ApiResponse response) onSuccess,
  }) async {
    isLoading.value = true;
    try {
      final response = await apiCall();
      if (response.isSuccess) {
        await onSuccess(response);
        SnackbarHelper.successSnackbar(
            response.message ?? "Login successfully");
      } else {
        SnackbarHelper.errorSnackbar(response.message ?? "");
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
      SnackbarHelper.errorSnackbar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
