import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/helper/snack_bar_helper.dart';
import 'package:pic_share/app/services/local_storage_service.dart';
import 'package:pic_share/app/services/notification_service.dart';
import 'package:pic_share/app/services/token_manager.dart';
import 'package:pic_share/data/models/user/user_model.dart';
import 'package:pic_share/data/repositories/auth/auth_repository.dart';
import 'package:pic_share/data/repositories/user/user_repository.dart';
import 'package:pic_share/view_model/app/session_controller.dart';
import 'package:pic_share/app/helper/device_info_helper.dart';

class RegisterController extends GetxController {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final LocalStorageService localStorageService;
  final _tokenManager = TokenManager();
  NotificationsService notificationsService;
  final SessionController sessionController;

  RegisterController({
    required this.authRepository,
    required this.userRepository,
    required this.localStorageService,
    required this.notificationsService,
    required this.sessionController,
  });

  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Rx<UserModel?> user = Rx<UserModel?>(null);
  RxBool isPassVisibility = false.obs;
  RxBool isConfirmPassVisibility = false.obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    // emailController = TextEditingController();
    // passController = TextEditingController();
    // nameController = TextEditingController();
    // confirmPasswordController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    // emailController.dispose();
    // passController.dispose();
    // nameController.dispose();
    // confirmPasswordController.dispose();
    super.onClose();
  }

  void onChangePassVisibility() {
    isPassVisibility.value = !isPassVisibility.value;
  }

  void onChangeConfirmPassVisibility() {
    isConfirmPassVisibility.value = !isConfirmPassVisibility.value;
  }

  Future<void> registerUserByEmailAndPass() async {
    isLoading.value = true;
    try {
      var isValid = formKey.currentState!.validate();
      if (isValid) {
        final deviceId = await DeviceInfoHelper.getDeviceId();
        final deviceName = await DeviceInfoHelper.getDeviceName();
        final response = await authRepository.registerUserByEmailAndPass(
          email: emailController.text.trim(),
          password: passController.text,
          confirmPassword: confirmPasswordController.text,
          name: nameController.text.trim(),
          deviceId: deviceId,
          deviceName: deviceName,
        );

        if (response.isSuccess) {
          user.value = response.data;
          await setToken();
          SnackbarHelper.successSnackbar(
              response.message ?? "Register successfully");
        } else {
          SnackbarHelper.errorSnackbar(response.message ?? "");
        }
      } else {
        debugPrint("Form is not valid");
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
      SnackbarHelper.errorSnackbar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> setToken() async {
    await _tokenManager.setAccessToken(user.value?.accessToken);
    await _tokenManager.setRefreshToken(user.value?.refreshToken);
    await sessionController.fetchToken();
    String? token = await notificationsService.getToken();
    if (token != null) {
      await updateFcmToken(token);
    }
    localStorageService.setUserModel(value: user.value);
  }

  Future<void> updateFcmToken(String token) async {
    final responseFCM = await userRepository.updateFcmToken(fcmToken: token);

    if (responseFCM.isSuccess) {
      user.value = user.value
          ?.copyWith(config: user.value?.config?.copyWith(fcmToken: token));
    }
  }
}
