import 'package:get/get.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
import 'package:pic_share/view_model/profile/profile_controller.dart';

class ProfileBindinsgs extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(
      () => ProfileController(
        authController: Get.find<AuthController>(),
      ),
    );
  }
}
