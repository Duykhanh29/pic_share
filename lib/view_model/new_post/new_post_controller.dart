import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/glocal_data.dart';
import 'package:pic_share/app/utils/date_utils.dart' as date;
import 'package:pic_share/app/utils/file_utils.dart';
import 'package:pic_share/data/enums/shared_post_type.dart';
import 'package:pic_share/data/models/post/post.dart';
import 'package:pic_share/data/models/user/friend.dart';
import 'package:pic_share/data/models/user/user_model.dart';
import 'package:pic_share/data/repositories/posts/post_repository.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
import 'package:pic_share/view_model/friend/friend_controller.dart';

class NewPostController extends GetxController {
  PostRepository postRepository;
  FriendController friendController;
  AuthController authController;
  UserModel? get currentUser => authController.getCurrentUser;
  NewPostController(
      {required this.postRepository,
      required this.friendController,
      required this.authController});
  List<Friend> get friends => friendController.friends;

  late CameraController cameraController;
  RxBool isFontCamera = true.obs;
  RxBool isCameraInitialized = false.obs;
  Rx<XFile?> pictureFile = Rx<XFile?>(null);
  RxBool isEnableFlash = false.obs;
  RxBool isSelectAllUser = true.obs;
  RxList<bool> listSelectedUser = <bool>[].obs;
  String get currentTime =>
      date.DateUtils.getStringCurrentTimeInHourAndMinutes();

  bool get isReadyToUpload =>
      isSelectAllUser.value == true ||
      !listSelectedUser.every((element) => element == false);
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
          listSelectedUser.value =
              List.generate(friends.length, (index) => false);
        }
      }
    } on CameraException catch (e) {
      // Handle the camera exception
      debugPrint('Camera exception: $e');
    } catch (e) {
      debugPrint('Error occured while taking picture: $e');
    }
  }

  void onChangeSelectedUser(int index) {
    listSelectedUser[index] = !listSelectedUser[index];
    bool allTrue = listSelectedUser.every((element) => element == true);
    if (allTrue) {
      isSelectAllUser.value = true;
      listSelectedUser.value = List.generate(friends.length, (index) => false);
    } else {
      isSelectAllUser.value = false;
    }
  }

  void onChangeSelectAllUser() {
    isSelectAllUser.value = !isSelectAllUser.value;
    listSelectedUser.value = List.generate(friends.length, (index) => false);
  }

  void onSetToDefault() {
    pictureFile.value = null;
    listSelectedUser.value = List.generate(friends.length, (index) => false);
    isSelectAllUser.value = true;
    captionController.clear();
    isEnableFlash.value = false;
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

  // api operation

  Future<void> createPost() async {
    try {
      if (isReadyToUpload) {
        SharedPostType type = getType();
        List<int> shareWiths = getShareWiths();
        Post? post = await postRepository.createPost(
          type: type,
          urlImage: File(pictureFile.value?.path ?? ""),
          caption: captionController.text.trim(),
          shareWiths: shareWiths,
        );
      }
    } catch (e) {
      debugPrint('Error occured while downloading picture: $e');
    } finally {
      onSetToDefault();
    }
  }

  List<int> getShareWiths() {
    List<int> shareWiths = [];
    for (int i = 0; i < friends.length; i++) {
      if (listSelectedUser[i]) {
        if (currentUser?.id != friends[i].friendId) {
          shareWiths.add(friends[i].friendId);
        } else {
          shareWiths.add(friends[i].userId);
        }
      }
    }
    return shareWiths;
  }

  SharedPostType getType() {
    if (isSelectAllUser.value) {
      return SharedPostType.allFriends;
    } else {
      return SharedPostType.groupMembers;
    }
  }

  @override
  void onClose() {
    captionController.dispose();
    cameraController.dispose();
    super.onClose();
  }
}
