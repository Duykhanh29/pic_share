import 'package:get/get.dart';
import 'package:pic_share/app/services/local_storage_service.dart';
import 'package:pic_share/app/services/notification_service.dart';
import 'package:pic_share/data/repositories/auth/auth_repository.dart';
import 'package:pic_share/data/repositories/user/user_repository.dart';
import 'package:pic_share/view_model/register/register_controller.dart';

class RegisterBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
      () => RegisterController(
        localStorageService: Get.find<LocalStorageService>(),
        authRepository: Get.find<AuthRepository>(),
        userRepository: Get.find<UserRepository>(),
        notificationsService: Get.find<NotificationsService>(),
      ),
    );
  }
}
