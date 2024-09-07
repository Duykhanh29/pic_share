import 'package:get/get.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
import 'package:pic_share/view_model/drawer/drawer_controller.dart';
import 'package:pic_share/view_model/friend/friend_controller.dart';

class AppDrawerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppDrawerController>(
      () => AppDrawerController(
        authController: Get.find<AuthController>(),
        friendController: Get.find<FriendController>(),
      ),
    );
  }
}
