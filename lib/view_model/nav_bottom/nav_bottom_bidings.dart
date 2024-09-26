import 'package:get/get.dart';
import 'package:pic_share/data/repositories/friend/friend_repository.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
import 'package:pic_share/view_model/drawer/drawer_controller.dart';
import 'package:pic_share/view_model/friend/friend_controller.dart';
import 'package:pic_share/view_model/nav_bottom/nav_bottom_controller.dart';

class NavBottomBindinngs extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<FriendController>()) {
      Get.put(
          FriendController(
            friendRepository: Get.find<FriendRepository>(),
            authController: Get.find<AuthController>(),
          ),
          permanent: true);
    }

    Get.put<AppDrawerController>(
      AppDrawerController(
        authController: Get.find<AuthController>(),
        friendController: Get.find<FriendController>(),
      ),
    );
    if (!Get.isRegistered<NavBottomController>()) {
      Get.put<NavBottomController>(
        NavBottomController(),
        permanent: true,
      );
    }
  }
}
