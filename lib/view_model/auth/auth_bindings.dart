import 'package:get/get.dart';
import 'package:pic_share/data/repositories/auth/auth_repository.dart';
import 'package:pic_share/data/repositories/user/user_repository.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
import 'package:pic_share/view_model/drawer/drawer_controller.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(
      AuthController(
        authRepository: Get.find<AuthRepository>(),
        userRepository: Get.find<UserRepository>(),
      ),
    );
    Get.put(
      AppDrawerController(authController: Get.find<AuthController>()),
    );
  }
}
