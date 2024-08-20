import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class PhotoHelper {
  static Future<XFile?> pickPhoto() async {
    var status = await Permission.photos.status;

    if (status.isDenied) {
      // User denied access, or it's permanently denied
      status = await Permission.photos.request();
    }

    if (status.isPermanentlyDenied) {
      _openPhotosSettings();
    } else {
      return await _startPhotoPicking();
    }
    return null;
  }

  static Future<XFile?> takePhoto() async {
    var status = await Permission.camera.status;

    if (status.isDenied) {
      // User denied access, or it's permanently denied
      status = await Permission.camera.request();
    }

    if (status.isPermanentlyDenied) {
      _openPhotosSettings();
    } else {
      return await _startPhotoShooting();
    }
    return null;
  }

  static void _openPhotosSettings() {
    Get.dialog(
      AlertDialog(
        title: const Text('Permission Needed'),
        content: const Text(
            'Photo access is required to select pictures. Please enable it in the app settings.'),
        actions: <Widget>[
          TextButton(
            child: const Text('Open Settings'),
            onPressed: () {
              openAppSettings(); // This opens app settings
              Get.back(); // Close the dialog after opening settings
            },
          ),
        ],
      ),
    );
  }

  static Future<XFile?> _startPhotoPicking() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        return image;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  static Future<XFile?> _startPhotoShooting() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        return image;
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
