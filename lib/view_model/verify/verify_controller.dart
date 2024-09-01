import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class VerifyController extends GetxController {
  late TextEditingController emailController;
  final formKey = GlobalKey<FormState>();
  @override
  void onInit() {
    emailController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
