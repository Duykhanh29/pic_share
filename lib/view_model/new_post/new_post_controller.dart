import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/glocal_data.dart';
import 'package:pic_share/app/utils/date_utils.dart' as date;
import 'package:pic_share/app/utils/file_utils.dart';

class NewPostController extends GetxController {
  late CameraController cameraController;
  RxBool isFontCamera = true.obs;
  RxBool isCameraInitialized = false.obs;
  Rx<XFile?> pictureFile = Rx<XFile?>(null);
  RxBool isEnableFlash = false.obs;
  String get currentTime =>
      date.DateUtils.getStringCurrentTimeInHourAndMinutes();
  late TextEditingController captionController;
  @override
  void onInit() async {
    await initCamera();
    captionController = TextEditingController();

    ever(isFontCamera, (callback) async {
      debugPrint("Init again");
      await initCamera();
    });
    super.onInit();
  }

  void onSwitchFlashMode() {
    isEnableFlash.value = !isEnableFlash.value;
  }

  void resetTakePicture() {
    pictureFile.value = null;
  }

  Future<void> initCamera() async {
    isCameraInitialized.value = false;
    cameraController = CameraController(
      cameras[isFontCamera.value ? 0 : 1],
      ResolutionPreset.max,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    await cameraController.initialize();
    isCameraInitialized.value = true;
  }

  void switchCamera() {
    isFontCamera.value = !isFontCamera.value;
  }

  Future<void> takePicture() async {
    try {
      if (cameraController.value.isInitialized) {
        if (!cameraController.value.isTakingPicture) {
          if (isEnableFlash.value) {
            await cameraController.setFlashMode(FlashMode.torch);
          }
          pictureFile.value = await cameraController.takePicture();
          if (isEnableFlash.value) {
            await cameraController.setFlashMode(FlashMode.off);
          }
        }
      }
    } on CameraException catch (e) {
      // Handle the camera exception
      debugPrint('Camera exception: $e');
    } catch (e) {
      debugPrint('Error occured while taking picture: $e');
    }
  }

  Future<void> onDownloadImageToGallery() async {
    try {
      if (pictureFile.value != null) {
        await FileUtils()
            .saveImageFromFileToGallery(File(pictureFile.value!.path));
      }
    } catch (e) {
      debugPrint('Error occured while downloading picture: $e');
    }
  }

  @override
  void onClose() {
    captionController.dispose();
    cameraController.dispose();
    super.onClose();
  }
}
