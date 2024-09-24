import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/services/local_storage_service.dart';
import 'package:pic_share/app/services/notification_service.dart';
import 'package:pic_share/app/services/token_manager.dart';
import 'package:pic_share/data/models/user/user_model.dart';
import 'package:pic_share/data/repositories/auth/auth_repository.dart';
import 'package:pic_share/data/repositories/user/user_repository.dart';

class RegisterController extends GetxController {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final LocalStorageService localStorageService;
  final _tokenManager = TokenManager();
  NotificationsService notificationsService;

  RegisterController({
    required this.authRepository,
    required this.userRepository,
    required this.localStorageService,
    required this.notificationsService,
  });

  final formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passController;
  late TextEditingController nameController;
  late TextEditingController confirmPasswordController;

  Rx<UserModel?> user = Rx<UserModel?>(null);
  RxBool isPassVissibility = false.obs;
  RxBool isConfirmPassVissibility = false.obs;
  @override
  void onInit() {
    emailController = TextEditingController();
    passController = TextEditingController();
    nameController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    passController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void onChangePassVissibility() {
    isPassVissibility.value = !isPassVissibility.value;
  }

  void onChangeConfirmPassVissibility() {
    isConfirmPassVissibility.value = !isConfirmPassVissibility.value;
  }

  Future<void> registerUserByEmailAndPass() async {
    try {
      var isValid = formKey.currentState!.validate();
      if (isValid) {
        user.value = await authRepository.registerUserByEmailAndPass(
            email: emailController.text.trim(),
            password: passController.text,
            confirmPassword: confirmPasswordController.text,
            name: nameController.text.trim());
        await _tokenManager.setAccessToken(user.value?.accessToken);
        String? token = await notificationsService.getToken();
        if (token != null) {
          await userRepository.updateFcmToken(fcmToken: token);
          user.value = user.value
              ?.copyWith(config: user.value?.config?.copyWith(fcmToken: token));
        }
        localStorageService.setUserModel(value: user.value);
      } else {
        debugPrint("Form is not valid");
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }
}
