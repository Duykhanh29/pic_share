import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/helper/snack_bar_helper.dart';
import 'package:pic_share/app/services/local_storage_service.dart';
import 'package:pic_share/app/services/notification_service.dart';
import 'package:pic_share/app/services/pusher_service.dart';
import 'package:pic_share/app/services/token_manager.dart';
import 'package:pic_share/data/models/user/user_model.dart';
import 'package:pic_share/data/repositories/auth/auth_repository.dart';
import 'package:pic_share/data/repositories/user/user_repository.dart';
import 'package:pic_share/routes/app_pages.dart';
import 'package:pic_share/view_model/friend/friend_controller.dart';
import 'package:pic_share/view_model/friend_profile/friend_profile_controller.dart';
import 'package:pic_share/view_model/home/home_controller.dart';
import 'package:pic_share/view_model/nav_bottom/nav_bottom_controller.dart';

class AuthController extends GetxController {
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final UserRepository userRepository;
  final AuthRepository authRepository;
  final LocalStorageService localStorageService;
  final _tokenManager = TokenManager();
  NotificationsService notificationsService;
  AuthController({
    required this.authRepository,
    required this.userRepository,
    required this.localStorageService,
    required this.notificationsService,
  });
  Rx<UserModel?> currentUser = Rx<UserModel?>(null);

  UserModel? get getCurrentUser => currentUser.value;

  String get language => currentUser.value?.config?.language ?? "en";

  @override
  void onInit() async {
    currentUser.value = localStorageService.userModel;
    super.onInit();

    notificationsService.onTokenRefreshCallback = (newToken) async {
      await userRepository.updateFcmToken(fcmToken: newToken);
      UserModel? user = currentUser.value?.copyWith(
          config: currentUser.value?.config?.copyWith(fcmToken: newToken));
      localStorageService.setUserModel(value: user, isUpdateUserNull: false);
      debugPrint('Updated token and user model');
    };
  }

  @override
  onReady() async {
    if (currentUser.value == null) {
      Get.offAllNamed(Routes.login);
    } else {
      Get.offAllNamed(Routes.navBar);
    }
    ever(localStorageService.isUserNull, (callback) {
      if (callback) {
        // logout();
      } else {
        Get.offAllNamed(Routes.navBar);
      }
      currentUser.value = localStorageService.userModel;
    });
  }

  void setUser(UserModel? user) {
    currentUser.value = user;
  }

  Future<void> logout() async {
    try {
      await updateFCMToken(isNull: true);
      final response = await authRepository.logout();
      if (response.isSuccess) {
        SnackbarHelper.successSnackbar(
            response.message ?? "Logout successfully");
      } else {
        SnackbarHelper.errorSnackbar(response.message ?? "");
      }
      localStorageService.removeAllSharedPreferencesValues();
      await _tokenManager.deleteAll();
      resetIndexes();
      deleteControllerDependenciesInjection();
      currentUser.value = null;
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      Get.offAllNamed(Routes.login);
    }
  }

  Future<void> updateUserInfo(
      {String? name, File? urlAvatar, String? language}) async {
    try {
      final response = await userRepository.updateUserInfo(
          name: name, urlAvatar: urlAvatar, language: language);

      if (response.isSuccess) {
        final userResponse = await userRepository.getCurrentUser();
        if (userResponse.isSuccess) {
          final user = userResponse.data;
          if (user != null) {
            localStorageService.setUserModel(value: user);
            setUser(user);
          }
        }
        SnackbarHelper.successSnackbar(
            response.message ?? "Update successfully");
      } else {
        SnackbarHelper.errorSnackbar(response.message ?? "");
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
      SnackbarHelper.errorSnackbar(e.toString());
    }
  }

  Future<void> changePassword(
      {required String currentPassword,
      required String newPassword,
      required String passwordConfirmation}) async {
    try {
      await userRepository.changePassword(
          currentPassword: currentPassword,
          newPassword: newPassword,
          passwordConfirmation: passwordConfirmation);
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
      SnackbarHelper.errorSnackbar(e.toString());
    }
  }

  Future<void> deleteUser() async {
    try {
      await userRepository.deleteUser();
      currentUser.value = null;
      Get.offAllNamed(Routes.login);
      localStorageService.removeAllSharedPreferencesValues();
      _tokenManager.deleteAll();
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
      SnackbarHelper.errorSnackbar(e.toString());
    }
  }

  Future<void> updateFCMToken({bool isNull = false}) async {
    try {
      String? fcmToken = await notificationsService.getToken();
      if (isNull) fcmToken = null;
      await userRepository.updateFcmToken(fcmToken: fcmToken);
      UserModel? user = currentUser.value?.copyWith(
          config:
              currentUser.value?.config?.customCopyWith(fcmToken: fcmToken));
      localStorageService.setUserModel(value: user, isUpdateUserNull: false);
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }

  Future<void> deleteControllerDependenciesInjection() async {
    try {
      await Get.delete<PusherService>();
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }

  void resetIndexes() {
    final isRegisteredNavBottom = Get.isRegistered<NavBottomController>();
    final isRegisteredHome = Get.isRegistered<HomeController>();
    final isRegisteredFriend = Get.isRegistered<FriendController>();
    final isRegisteredFriendProfile =
        Get.isRegistered<FriendProfileController>();
    if (isRegisteredNavBottom) {
      final navBottomController = Get.find<NavBottomController>();
      navBottomController.resetIndexes();
    }
    if (isRegisteredHome) {
      final homeController = Get.find<HomeController>();
      homeController.resetIndexes();
    }
    if (isRegisteredFriend) {
      final friendController = Get.find<FriendController>();
      friendController.resetToDefault();
    }
    if (isRegisteredFriendProfile) {
      final friendProfileController = Get.find<FriendProfileController>();
      friendProfileController.onResetTabIndex();
    }
  }

  /* OLD VERSION ( USING FIREBASE AUTH)
  void obseverUserState() {
    _firebaseAuth.authStateChanges().listen((user) {
      currentUser.value = user;
      if (user == null) {
        Get.offAllNamed(Routes.login);
      } else {
        Get.offAllNamed(Routes.navBar);
      }
    });
  }

  Future<void> getUserModelChanged() async {
    ever(currentUser, (callback) async {
      if (currentUser.value != null) {
        await userRepository.createUser(currentUser.value!);

        await getCurrentUserModelData();
      }
    });
  }

  Future<void> getCurrentUserModelData() async {
    try {
      currentUserModel.value = await userRepository.getCurrentUserModel();
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }

  Future<void> updateUserInfo(Map<String, dynamic> jsonData) async {
    try {
      await userRepository.updateUser(
          uid: currentUser.value!.uid, userData: jsonData);
      await getCurrentUserModelData();
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }
  */
}
