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
  Future<bool?> saveImageFromUrlToGallery(String imageUrl) async {
    // Check and request permissions
    await Permission.storage.request();

    try {
      await Future.delayed(
          const Duration(seconds: 5)); // add delay to completely load image
      final response = await Dio().get(
        imageUrl,
        options: Options(responseType: ResponseType.bytes, headers: {
          "Connection": "Keep-Alive",
          "Keep-Alive": "timeout=5, max=1000"
        }),
      );

      if (response.statusCode == 200) {
        final imageBytes = response.data;

        // Save image to temporary file
        final tempDir = await getTemporaryDirectory();
        final tempFile = File(
            '${tempDir.path}/image_${DateTime.now().millisecondsSinceEpoch}.jpg');
        await tempFile.writeAsBytes(imageBytes);

        // Save image to gallery
        final result = await GallerySaver.saveImage(tempFile.path);
        debugPrint('Image saved to gallery: $result');
        return result;
      } else {
        debugPrint('Failed to load image: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error saving image: $e');
    }
    return null;
  }

  Future<void> saveImageFromFileToGallery(File imageFile) async {
    //Check and request permissions
    await Permission.storage.request();

    try {
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
