import 'package:get/get.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
import 'package:pic_share/view_model/change_password/change_pass_controller.dart';

class ChangePasswordBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordController>(
      () => ChangePasswordController(
        authController: Get.find<AuthController>(),
      ),
    );
  }
}
