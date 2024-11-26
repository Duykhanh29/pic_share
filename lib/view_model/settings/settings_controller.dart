import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/strings.dart';
import 'package:pic_share/app/helper/snack_bar_helper.dart';
import 'package:pic_share/app/services/local_storage_service.dart';
import 'package:pic_share/app/services/notification_service.dart';
import 'package:pic_share/data/models/user/user_model.dart';
import 'package:pic_share/routes/app_pages.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
import 'package:pic_share/view_model/friend/friend_controller.dart';

class SettingsController extends GetxController {
  AuthController authController;
  FriendController friendController;
  LocalStorageService localStorageService;
  NotificationsService notificationsService;
  SettingsController({
    required this.authController,
    required this.friendController,
    required this.localStorageService,
    required this.notificationsService,
  });

  Rx<UserModel?> get currentUser => authController.currentUser;

  String get language => authController.language;
  RxBool isShowNotification = true.obs;
  RxBool isShowNotificationWithSound = true.obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    ever(authController.currentUser, (user) {
      if (user != null) {
        currentUser.value = user;
      }
    });
    _initializeNotificationSettings();
    super.onInit();
  }

  Future<void> _initializeNotificationSettings() async {
    isShowNotification.value =
        await notificationsService.getNotificationSettings();
  }

  Future<void> logout() async {
    isLoading.value = true;
    try {
      await authController.logout();
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
      SnackbarHelper.errorSnackbar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteUser() async {
    try {
      await authController.deleteUser();
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
      SnackbarHelper.errorSnackbar(e.toString());
    }
  }

// user section
  void onNavToProfile() {
    Get.toNamed(Routes.profile);
  }

  void onNavToEditProfile() {
    Get.toNamed(Routes.editProfile);
  }

// user settings

  void onNavToFriend() {
    Get.toNamed(Routes.friend);
    friendController.onNavToPage();
  }

  void onNavToUserCode() {
    Get.toNamed(
      Routes.search,
      arguments: {
        Strings.isSearchWithUserCode: true,
      },
    );
  }

  void onNavToPostsWithLocation() {
    Get.toNamed(
      Routes.postsWithLocation,
    );
  }

  void onNavToPostsLocation() {
    Get.toNamed(
      Routes.postsLocation,
    );
  }

  void onNavToHistory() {
    Get.toNamed(Routes.postHistory);
  }

  // general settings
  void onNavToLanguage() {
    Get.toNamed(Routes.language);
  }

  void onNavNotificationSettings() {
    Get.toNamed(Routes.notificationSettings);
  }

  // acc settings

  void onNavToSecurity() {
    Get.toNamed(Routes.security);
  }

  // notification settings
  Future<void> onChangeShowNotification(bool value) async {
    isShowNotification.value = value;
    if (!isShowNotification.value) {
      if (isShowNotificationWithSound.value) {
        isShowNotificationWithSound.value = false;
      }
      await authController.updateFCMToken(isNull: true);
    } else {
      bool hasPermission = await notificationsService.getNotificationSettings();

      if (!hasPermission) {
        final result = await notificationsService.requestPermission();
        localStorageService.setNotificationPermission(result);
        if (result) {
          await authController.updateFCMToken();
        }
      } else {
        await authController.updateFCMToken();
      }
    }
  }

  void onChangeShowNotificationWithSound(bool value) {
    isShowNotificationWithSound.value = value;
  }

  Future<void> checkNotificationPermission() async {
    bool hasPermission = localStorageService.notificationPermission;

    if (!hasPermission) {
      NotificationSettings settings =
          await FirebaseMessaging.instance.requestPermission();

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        debugPrint('User granted notification permission');
        localStorageService.setNotificationPermission(true);
      } else {
        debugPrint('User denied or did not grant permission');
        localStorageService.setNotificationPermission(false);
      }
    } else {
      debugPrint('Notification permission already granted');
    }
  }
}
