import 'package:get/get.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
import 'package:pic_share/view_model/edit_profile/edit_profile_controller.dart';

class EditProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileController>(
      () => EditProfileController(
        authController: Get.find<AuthController>(),
      ),
    );
  }
}
