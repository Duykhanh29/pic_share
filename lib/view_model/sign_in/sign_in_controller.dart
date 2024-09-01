import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/services/local_storage_service.dart';
import 'package:pic_share/app/services/token_manager.dart';
import 'package:pic_share/data/models/user/user_model.dart';
import 'package:pic_share/data/repositories/auth/auth_repository.dart';
import 'package:pic_share/data/repositories/user/user_repository.dart';

class SignInController extends GetxController {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final LocalStorageService localStorageService;
  final _tokenManager = TokenManager();
  Rx<UserModel?> user = Rx<UserModel?>(null);
  SignInController(
      {required this.authRepository,
      required this.userRepository,
      required this.localStorageService});
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passController;
  RxBool isPassVissibility = false.obs;

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

  void onChangePassVissibility() {
    isPassVissibility.value = !isPassVissibility.value;
  }

  Future<void> signInWithEmailPass() async {
    try {
      var isValid = formKey.currentState!.validate();
      if (isValid) {
        user.value = await authRepository.signInWithEmailPass(
            email: emailController.text.trim(), password: passController.text);
        localStorageService.setUserModel(value: user.value);
        _tokenManager.setAccessToken(user.value?.accessToken);
      } else {
        debugPrint('form is not valid');
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      user.value = await authRepository.signInWithGoogle();
      localStorageService.setUserModel(value: user.value);
      _tokenManager.setAccessToken(user.value?.accessToken);
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }
}
