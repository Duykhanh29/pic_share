import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/data/repositories/auth/auth_repository.dart';
import 'package:pic_share/data/repositories/user/user_repository.dart';

class RegisterController extends GetxController {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final Rxn<User> user = Rxn<User>();

  RegisterController(
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

  Future<void> registerUserByEmailAndPass() async {
    try {
      var isValid = formKey.currentState!.validate();
      if (isValid) {
        user.value = await authRepository.registerUserByEmailAndPass(
            email: emailController.text.trim(), password: passController.text);
      } else {
        debugPrint("Form is not valid");
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }
}
