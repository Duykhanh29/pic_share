import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/helper/snack_bar_helper.dart';
import 'package:pic_share/app/services/local_storage_service.dart';
import 'package:pic_share/app/services/notification_service.dart';
import 'package:pic_share/app/services/token_manager.dart';
import 'package:pic_share/data/enums/role_type.dart';
import 'package:pic_share/data/models/user/user_model.dart';
import 'package:pic_share/data/repositories/auth/auth_repository.dart';
import 'package:pic_share/data/repositories/user/user_repository.dart';
import 'package:pic_share/routes/app_pages.dart';

class SignInController extends GetxController {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final LocalStorageService localStorageService;
  NotificationsService notificationsService;
  final _tokenManager = TokenManager();
  Rx<UserModel?> user = Rx<UserModel?>(null);
  SignInController({
    required this.authRepository,
    required this.userRepository,
    required this.localStorageService,
    required this.notificationsService,
  });
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passController;
  RxBool isPassVisibility = false.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    emailController = TextEditingController();
    passController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    passController.dispose();
    super.onClose();
  }

  void onChangePassVisibility() {
    isPassVisibility.value = !isPassVisibility.value;
  }

  Future<void> signInWithEmailPass() async {
    isLoading.value = true;
    try {
      var isValid = formKey.currentState!.validate();
      if (isValid) {
        final response = await authRepository.signInWithEmailPass(
            email: emailController.text.trim(), password: passController.text);
        if (response.isSuccess) {
          user.value = response.data;
          if (user.value != null) {
            if (user.value!.roleType == RoleType.admin) {
              Get.toNamed(Routes.adminPage);
            } else {
              await _tokenManager.setAccessToken(user.value?.accessToken);
              String? token = await notificationsService.getToken();

              if (token != null) {
                debugPrint("TOken of FCM is: $token");
                await userRepository.updateFcmToken(fcmToken: token);
                user.value = user.value?.copyWith(
                    config: user.value?.config?.copyWith(fcmToken: token));
              }
              localStorageService.setUserModel(value: user.value);
              SnackbarHelper.successSnackbar(
                  response.message ?? "Login successfully");
            }
          }
        } else {
          SnackbarHelper.errorSnackbar(response.message ?? "");
        }
      } else {
        debugPrint('form is not valid');
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
      SnackbarHelper.errorSnackbar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    try {
      final response = await authRepository.signInWithGoogle();
      if (response.isSuccess) {
        user.value = response.data;
        await _tokenManager.setAccessToken(user.value?.accessToken);
        String? token = await notificationsService.getToken();
        if (token != null) {
          await userRepository.updateFcmToken(fcmToken: token);
          user.value = user.value
              ?.copyWith(config: user.value?.config?.copyWith(fcmToken: token));
        }
        localStorageService.setUserModel(value: user.value);
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
