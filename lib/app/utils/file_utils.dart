import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

class FileUtils {
  // gallery saver
  Future<void> saveImageFromUrlToGallery(String imageUrl) async {
    // Kiểm tra và yêu cầu quyền
    await Permission.storage.request();

    try {
      final response = await Dio()
          .get(imageUrl, options: Options(responseType: ResponseType.bytes));
      final imageBytes = response.data;

      // Lưu ảnh bằng gallery_saver_plus
      final result = await GallerySaver.saveImage(imageBytes);
      debugPrint('Image saved to gallery: $result');
    } catch (e) {
      debugPrint('Error saving image: $e');
    }
  }

  Future<void> saveImageFromFileToGallery(File imageFile) async {
    // Kiểm tra và yêu cầu quyền
    await Permission.storage.request();

    try {
      // Lưu ảnh bằng gallery_saver_plus
      final result = await GallerySaver.saveImage(imageFile.path);
      debugPrint('Image saved to gallery: $result');
    } catch (e) {
      debugPrint('Error saving image: $e');
    }
  }

  //
  Future<bool> _requestStoragePermission() async {
    AndroidDeviceInfo build = await DeviceInfoPlugin().androidInfo;

    if (build.version.sdkInt >= 30) {
      var status = await Permission.manageExternalStorage.request();
      if (status.isGranted) {
        return true;
      } else {
        return false;
      }
    }
    var status = await Permission.storage.status;

    if (status.isDenied) {
      status = await Permission.storage.request();
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
      // return false;
    }
    return status.isGranted;
  }

  Future<String> getDirectoryPath() async {
    if (await _requestStoragePermission()) {
      // Assuming you want to save images in the app's document directory
      final directory = await getApplicationDocumentsDirectory();
      final path = directory.path;
      return path;
    } else {
      // Handle permission denied case
      return '';
    }
  }

  Future<void> saveImageToGallery(Uint8List imageBytes) async {
    final directoryPath = await getDirectoryPath();
    if (directoryPath.isNotEmpty) {
      final imagePath =
          '$directoryPath/image.jpg'; // Replace 'image.jpg' with desired filename
      final file = File(imagePath);
      await file.writeAsBytes(imageBytes);
      // You might want to add code here to broadcast the image to the gallery
    } else {
      // Handle permission denied or directory not found case
    }
  }

  Future<Uint8List> getImageBytesFromUrl(String imageUrl) async {
    try {
      final dio = Dio();
      final response = await dio.get(imageUrl,
          options: Options(responseType: ResponseType.bytes));

      return response.data;
    } catch (e) {
      debugPrint('Something went wrong: $e');
      rethrow;
    }
  }

  Future<Uint8List> getImageBytesFromFile(File file) async {
    return await file.readAsBytes();
  }
}
