import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/helper/snack_bar_helper.dart';
import 'package:pic_share/app/services/local_storage_service.dart';
import 'package:pic_share/app/services/notification_service.dart';
import 'package:pic_share/app/services/pusher_service.dart';
import 'package:pic_share/app/services/token_manager.dart';
import 'package:pic_share/data/models/auth/qrcode_response.dart';
import 'package:pic_share/data/models/user/user_model.dart';
import 'package:pic_share/data/providers/network/api_response.dart';
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

  RxBool actionLoading = false.obs;

  RxString resetEmail = "".obs;
  RxInt otpValidity = 0.obs;

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

  void setIsEnable2Fa(bool value) {
    currentUser.value = currentUser.value?.copyWith(isEnable2FA: value);
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

  Future<void> updateUserInfo({
    String? name,
    File? urlAvatar,
    String? language,
    bool? isEnableLoginEmail,
  }) async {
    try {
      actionLoading.value = true;
      final response = await userRepository.updateUserInfo(
        name: name,
        urlAvatar: urlAvatar,
        language: language,
        isEnableLoginEmail: isEnableLoginEmail,
      );

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
    } finally {
      actionLoading.value = false;
    }
  }

  Future<ApiResponse> changePassword(
      {required String currentPassword,
      required String newPassword,
      required String passwordConfirmation}) async {
    final response = await userRepository.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        passwordConfirmation: passwordConfirmation);
    return response;
  }

  Future<void> deleteUser() async {
    try {
      await userRepository.deleteUser();
      currentUser.value = null;
      localStorageService.removeAllSharedPreferencesValues();
      _tokenManager.deleteAll();
      deleteControllerDependenciesInjection();
      resetIndexes();
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
      SnackbarHelper.errorSnackbar(e.toString());
    } finally {
      Get.offAllNamed(Routes.login);
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

  Future<QRCodeResponse?> updateState2FA(
      {required String password, required bool isEnable}) async {
    try {
      actionLoading.value = true;
      final response = await authRepository.updateState2FA(password: password);

      // check isEnable is false and handle in if block because.
      // When it comes to false, it means user want to disable 2FA
      // but, if isEnable is true, it just first step in 2 step verification
      if (response.isSuccess && !isEnable) {
        localStorageService.setIsEnable2Fa(isEnable);
        setIsEnable2Fa(isEnable);
        SnackbarHelper.successSnackbar(response.message ?? "");
      }
      if (!response.isSuccess) {
        SnackbarHelper.errorSnackbar(
            response.message ?? "Some thing went wrong");
      }
      return response.data;
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      actionLoading.value = false;
    }
    return null;
  }

  Future<void> confirmEnable2FA({required String code}) async {
    try {
      actionLoading.value = true;
      final response = await authRepository.confirmEnable2FA(code: code);
      if (response.isSuccess) {
        localStorageService.setIsEnable2Fa(response.isSuccess);
        setIsEnable2Fa(response.isSuccess);
        SnackbarHelper.successSnackbar(response.message ?? "");
      } else {
        SnackbarHelper.errorSnackbar(response.message ?? "");
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      actionLoading.value = false;
    }
  }

  Future<void> check2FA({required String code}) async {
    try {
      actionLoading.value = true;
      final response = await authRepository.verify2FA(code: code);
      if (response.isSuccess && response.data != null) {
        final userResponse = await userRepository.getCurrentUser();
        if (userResponse.isSuccess) {
          await _tokenManager.setRefreshToken(response.data!);
          final user = userResponse.data;
          await setUserData(user);
          Get.offAllNamed(Routes.navBar);
          SnackbarHelper.successSnackbar(response.message ?? "");
        }
      } else {
        SnackbarHelper.errorSnackbar(response.message ?? "");
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      actionLoading.value = false;
    }
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      actionLoading.value = true;
      final response = await authRepository.forgotPassword(email: email);
      if (response.isSuccess) {
        resetEmail.value = email;
        otpValidity.value = response.data ?? 0;
        Get.toNamed(Routes.resetPassword);
        SnackbarHelper.successSnackbar(response.message ?? "");
      } else {
        SnackbarHelper.errorSnackbar(response.message ?? "");
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      actionLoading.value = false;
    }
  }

  Future<void> resetPassword({
    required String password,
    required String otp,
    required String email,
    required String passwordConfirmation,
  }) async {
    try {
      actionLoading.value = true;
      final response = await authRepository.resetPassword(
        email: email,
        otp: otp,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      if (response.isSuccess) {
        Get.offAllNamed(Routes.login);
        SnackbarHelper.successSnackbar(response.message ?? "");
      } else {
        SnackbarHelper.errorSnackbar(response.message ?? "");
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      actionLoading.value = false;
    }
  }

  Future<void> deleteControllerDependenciesInjection() async {
    try {
      await Get.delete<PusherService>();
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }

  Future<void> setUserData(UserModel? user) async {
    if (user != null) {
      String? token = await notificationsService.getToken();
      UserModel? userData = user;
      if (token != null) {
        debugPrint("TOken of FCM is: $token");
        await userRepository.updateFcmToken(fcmToken: token);
        currentUser.value = currentUser.value?.copyWith(
            config: currentUser.value?.config?.copyWith(fcmToken: token));
        userData =
            user.copyWith(config: user.config?.copyWith(fcmToken: token));
      }
      localStorageService.setUserModel(
        value: userData,
      );
      // setUser(userData);
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
