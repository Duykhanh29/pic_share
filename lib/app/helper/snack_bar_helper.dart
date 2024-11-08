import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SnackbarHelper {
  static void successSnackbar(
    String message, {
    String title = 'Success',
    Duration duration = const Duration(seconds: 2),
    SnackPosition position = SnackPosition.TOP,
  }) {
    final locale = Get.locale;
    final context = Get.context;
    if (locale != null && context != null) {
      title = AppLocalizations.of(context)?.successTitle ?? 'Success';
    }
    Get.snackbar(
      title,
      message,
      duration: duration,
      snackPosition: position,
      icon: const Icon(
        Icons.check_circle_rounded,
        size: 32,
        color: Colors.green,
      ),
      backgroundColor: Colors.white,
    );
  }

  // Usage: SnackbarHelper.errorSnackbar('message', title: 'Error');
  static void errorSnackbar(
    String message, {
    String title = 'Error',
    Duration duration = const Duration(seconds: 2),
    SnackPosition position = SnackPosition.TOP,
  }) {
    final locale = Get.locale;
    final context = Get.context;
    if (locale != null && context != null) {
      title = AppLocalizations.of(context)?.errorTitle ?? 'Error';
    }
    Get.snackbar(
      title,
      message,
      duration: duration,
      snackPosition: position,
      icon: const Icon(
        Icons.cancel,
        size: 32,
        color: Colors.red,
      ),
      backgroundColor: Colors.white,
    );
  }

  static void warningSnackbar(
    String message, {
    String title = 'Warning',
    Duration duration = const Duration(seconds: 2),
    SnackPosition position = SnackPosition.TOP,
  }) {
    final locale = Get.locale;
    final context = Get.context;
    if (locale != null && context != null) {
      title = AppLocalizations.of(context)?.warningTitle ?? 'Warning';
    }
    Get.snackbar(
      title,
      message,
      duration: duration,
      snackPosition: position,
      icon: const Icon(
        Icons.warning_rounded,
        size: 32,
        color: Colors.amber,
      ),
      backgroundColor: Colors.white,
    );
  }
}
