import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/data/repositories/auth/auth_repository.dart';
import 'package:pic_share/data/repositories/user/user_repository.dart';

class SignInController extends GetxController {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final Rxn<User> user = Rxn<User>();
  SignInController(
      {required this.authRepository, required this.userRepository});
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  RxBool isPassVissibility = false.obs;
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
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }
}
