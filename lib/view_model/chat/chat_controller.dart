import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final messageController = TextEditingController();
  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }

  void onSubmitted(String value) {
    print(messageController.text);
  }
}
