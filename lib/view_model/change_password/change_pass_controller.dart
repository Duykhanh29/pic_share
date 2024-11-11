import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/helper/snack_bar_helper.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';

class ChangePasswordController extends GetxController {
  late TextEditingController currentPassController;
  late TextEditingController newPassController;
  late TextEditingController confirmNewPasswordController;
  final formKey = GlobalKey<FormState>();

  RxBool isCurrentPassVisibility = false.obs;
  RxBool isNewPassVisibility = false.obs;
  RxBool isConfirmNewPassVisibility = false.obs;
  RxBool isLoading = false.obs;

  AuthController authController;

  ChangePasswordController({required this.authController});

  @override
  void onInit() {
    currentPassController = TextEditingController();
    newPassController = TextEditingController();
    confirmNewPasswordController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    currentPassController.dispose();
    newPassController.dispose();
    confirmNewPasswordController.dispose();
    super.onClose();
  }

  void onChangeCurrentPassVisibility() {
    isCurrentPassVisibility.value = !isCurrentPassVisibility.value;
  }

  void onChangeNewPassVisibility() {
    isNewPassVisibility.value = !isNewPassVisibility.value;
  }

  void onChangeConfirmNewPassVisibility() {
    isConfirmNewPassVisibility.value = !isConfirmNewPassVisibility.value;
  }

  Future<void> onChangePassword() async {
    isLoading.value = true;
    try {
      var isValid = formKey.currentState!.validate();
      if (isValid) {
        await authController.changePassword(
          currentPassword: currentPassController.text.trim(),
          newPassword: newPassController.text.trim(),
          passwordConfirmation: confirmNewPasswordController.text.trim(),
        );
        Get.back();
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
}
