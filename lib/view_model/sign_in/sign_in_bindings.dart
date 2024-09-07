import 'package:get/get.dart';
import 'package:pic_share/app/services/local_storage_service.dart';
import 'package:pic_share/app/services/notification_service.dart';
import 'package:pic_share/data/repositories/auth/auth_repository.dart';
import 'package:pic_share/data/repositories/user/user_repository.dart';
import 'package:pic_share/view_model/sign_in/sign_in_controller.dart';

class SignInBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(
      () => SignInController(
        localStorageService: Get.find<LocalStorageService>(),
        authRepository: Get.find<AuthRepository>(),
        userRepository: Get.find<UserRepository>(),
        notificationsService: Get.find<NotificationsService>(),
      ),
    );
  }
}
