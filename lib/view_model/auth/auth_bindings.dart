import 'package:get/get.dart';
import 'package:pic_share/app/services/local_storage_service.dart';
import 'package:pic_share/app/services/notification_service.dart';
import 'package:pic_share/data/repositories/auth/auth_repository.dart';
import 'package:pic_share/data/repositories/user/user_repository.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
import 'package:pic_share/view_model/language/language_controller.dart';
import 'package:pic_share/view_model/app/app_controller.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<AppController>(AppController(), permanent: true);
    if (!Get.isRegistered<AuthController>()) {
      Get.put<AuthController>(
        AuthController(
          localStorageService: Get.find<LocalStorageService>(),
          authRepository: Get.find<AuthRepository>(),
          userRepository: Get.find<UserRepository>(),
          notificationsService: Get.find<NotificationsService>(),
        ),
      );
    }

    Get.put(
      LanguageController(
        localStorageService: Get.find<LocalStorageService>(),
        userRepository: Get.find<UserRepository>(),
        authController: Get.find<AuthController>(),
      ),
    );
  }
}
