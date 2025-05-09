import 'package:get/get.dart';
import 'package:pic_share/app/services/local_storage_service.dart';
import 'package:pic_share/data/repositories/user/user_repository.dart';
import 'package:pic_share/view_model/language/language_controller.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
class LanguageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LanguageController>(
      () => LanguageController(
        localStorageService: Get.find<LocalStorageService>(),
        userRepository: Get.find<UserRepository>(),
        authController: Get.find<AuthController>(),
      ),
    );
  }
}
