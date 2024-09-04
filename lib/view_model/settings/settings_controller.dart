import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/data/models/user/user_model.dart';
import 'package:pic_share/routes/app_pages.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';

class SettingsController extends GetxController {
  AuthController authController;

  SettingsController({required this.authController});

  UserModel? get currentUser => authController.getCurrentUser;

  String get language => authController.language;
  Future<void> logout() async {
    try {
      await authController.logout();
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }

  Future<void> deleteUser() async {
    try {
      await authController.deleteUser();
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }

  void onNavToProfile() {
    Get.toNamed(Routes.profile);
  }

  void onNavToLanguage() {
    Get.toNamed(Routes.language);
  }

  void onNavToChangePassword() {
    Get.toNamed(Routes.changePassword);
  }

  void onNavToEditProfile() {
    Get.toNamed(Routes.editProfile);
  }
}
