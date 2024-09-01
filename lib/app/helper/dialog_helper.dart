import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DialogHelper {
  static void showConfirmDialog(
    String title,
    String message,
    Function()? onConfirm,
    BuildContext context,
  ) {
    final t = AppLocalizations.of(context)!;
    Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Text(message),
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
            child: Text(t.cancel),
          ),
          TextButton(
            onPressed: () {
              onConfirm?.call();
              if (Get.isDialogOpen == true) {
                Get.back();
              }
            },
            child: Text(t.yes),
          ),
        ],
      ),
    );
  }
}
