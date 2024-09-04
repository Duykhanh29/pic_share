import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
import 'package:pic_share/view_model/conversations/conversations_controller.dart';
import 'package:pic_share/view_model/home/home_controller.dart';
import 'package:pic_share/view_model/new_post/new_post_controller.dart';
import 'package:pic_share/view_model/notifications/notification_controller.dart';
import 'package:pic_share/view_model/settings/settings_controller.dart';

class NavBottomController extends GetxController {
  final PersistentTabController pageController = PersistentTabController();
  RxInt pageIndex = 0.obs;
  @override
  void onInit() {
    if (pageIndex.value != 0) {
      pageIndex.value = 0;
    }
    Get.put(HomeController(), permanent: true);
    Get.put(NotificationController(), permanent: true);
    Get.put(NewPostController(), permanent: true);
    Get.put(ConversationsController(), permanent: true);
    Get.put(
        SettingsController(
          authController: Get.find<AuthController>(),
        ),
        permanent: true);
    super.onInit();
  }

  void changeNavigationPage(int index) {
    pageIndex.value = index;
    pageController.index = index;
  }
}
