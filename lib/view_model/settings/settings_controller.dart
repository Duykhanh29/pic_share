import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/strings.dart';
import 'package:pic_share/data/models/user/user_model.dart';
import 'package:pic_share/data/repositories/friend/friend_repository.dart';
import 'package:pic_share/routes/app_pages.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
import 'package:pic_share/view_model/friend/friend_controller.dart';

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

// user section
  void onNavToProfile() {
    Get.toNamed(Routes.profile);
  }

  void onNavToEditProfile() {
    Get.toNamed(Routes.editProfile);
  }

// user settings
  void onNavToLanguage() {
    Get.toNamed(Routes.language);
  }

  void onNavToFriend() {
    Get.toNamed(Routes.friend);
  }

  void onNavToUserCode() {
    Get.put(FriendController(friendRepository: Get.find<FriendRepository>()));
    Get.toNamed(
      Routes.search,
      arguments: {
        Strings.isSearchWithUserCode: true,
      },
    );
  }

  // acc settings

  void onNavToSecurity() {
    Get.toNamed(Routes.security);
  }
}
