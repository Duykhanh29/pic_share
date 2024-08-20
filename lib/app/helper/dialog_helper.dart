import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogHelper {
  static void showConfirmDialog(
      String title, String message, Function()? onConfirm) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete'),
        content: const Text('Are you sure you want to delete this photo?'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (Get.isDialogOpen == true) {
                Get.back();
              }
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              onConfirm?.call();
              if (Get.isDialogOpen == true) {
                Get.back();
              }
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
