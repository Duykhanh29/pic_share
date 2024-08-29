import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_images.dart';
import 'package:pic_share/app/services/local_storage_service.dart';
import 'package:pic_share/data/models/language.dart';
import 'package:pic_share/data/repositories/user/user_repository.dart';

class LanguageController extends GetxController {
  LocalStorageService localStorageService;
  UserRepository userRepository;

  List<Language> languages = [
    Language(code: 'en', image: AppImage.ukFlag),
    Language(code: 'vi', image: AppImage.vietnameFlag),
  ];

  Rx<int> selectedLanguage = 0.obs;

  LanguageController({
    required this.localStorageService,
    required this.userRepository,
  });

  @override
  void onInit() {
    getLanguageIndex();
    super.onInit();
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

  void onChangeLanguage(int index) {
    String code = languages[index].code;
    Get.updateLocale(Locale(code));
    localStorageService.setLanguage = code;
    selectedLanguage.value = index;
  }

  Future<void> updateLanguage() async {
    try {
      //
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }
}
