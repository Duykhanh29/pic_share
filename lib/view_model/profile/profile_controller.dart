import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pic_share/data/models/user/user_model.dart';
import 'package:pic_share/routes/app_pages.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';

class ProfileController extends GetxController {
  AuthController authController;
  ProfileController({required this.authController});

  UserModel? get currentUser => authController.getCurrentUser;

  void onNavToEditProfile() {
    Get.toNamed(Routes.editProfile);
  }

  void onCopyUserCode() {
    Clipboard.setData(ClipboardData(text: currentUser?.userCode ?? ""));
  }
}
