import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_images.dart';
import 'package:pic_share/app/services/local_storage_service.dart';
import 'package:pic_share/data/models/language.dart';
import 'package:pic_share/data/repositories/user/user_repository.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';

class LanguageController extends GetxController {
  LocalStorageService localStorageService;
  UserRepository userRepository;
  AuthController authController;

  List<Language> languages = [
    Language(code: 'en', image: AppImage.ukFlag, countryCode: 'UK'),
    Language(code: 'vi', image: AppImage.vietnameFlag, countryCode: 'VN'),
  ];

  Rx<int> selectedLanguage = 0.obs;
  String? get currentLanguage => Get.locale?.languageCode;

  LanguageController({
    required this.localStorageService,
    required this.userRepository,
    required this.authController,
  });

  @override
  void onInit() {
    getLanguageIndex();
    ever(authController.currentUser, (user) {
      if (user != null) {
        if (user.config != null && user.config!.language != currentLanguage) {
          String code = user.config!.language;
          Get.updateLocale(Locale(code));
          localStorageService.setLanguage = code;
          selectedLanguage.value = user.config!.language == 'en' ? 0 : 1;
        }
      }
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    if (localStorageService.language != null &&
        localStorageService.language != currentLanguage) {
      Get.updateLocale(Locale(localStorageService.language!));
    } else if (localStorageService.language == null) {
      Get.updateLocale(Locale(PlatformDispatcher.instance.locale.languageCode));
    } else if (Get.locale != null) {
      Get.updateLocale(Get.locale!);
    }
  }

  void getLanguageIndex() {
    String? currentLanguage = localStorageService.language;
    if (currentLanguage == null) {
      return;
    }
    for (var i = 0; i < languages.length; i++) {
      if (currentLanguage == languages[i].code) {
        selectedLanguage.value = i;
        break;
      }
    }
  }

  Future<void> onChangeLanguage(int index) async {
    try {
      String code = languages[index].code;
      Get.updateLocale(Locale(code));
      localStorageService.setLanguage = code;
      selectedLanguage.value = index;
      await userRepository.updateUserInfo(
        language: code,
      );
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }
}
