import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/helper/photo_helper.dart';
import 'package:pic_share/data/models/user/user_model.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';

class EditProfileController extends GetxController {
  late TextEditingController nameController;
  AuthController authController;
  UserModel? get currentUser => authController.getCurrentUser;
  EditProfileController({required this.authController});
  Rx<XFile?> avatarFile = Rx<XFile?>(null);
  RxBool isNewAvatar = false.obs;
  @override
  void onInit() {
    nameController =
        TextEditingController(text: authController.getCurrentUser?.name ?? "");
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }

  Future<void> pickAvatar() async {
    try {
      avatarFile.value = await PhotoHelper.pickPhoto();
      if (avatarFile.value != null) {
        isNewAvatar.value = true;
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }

  Future<void> updateUserInfo() async {
    try {
      if (nameController.text.isEmpty) return;
      await authController.updateUserInfo(
        name: nameController.text.trim() != authController.getCurrentUser?.name
            ? nameController.text.trim()
            : null,
        urlAvatar: isNewAvatar.value ? avatarFile.value!.path : null,
      );
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }
}
