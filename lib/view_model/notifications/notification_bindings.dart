import 'package:get/get.dart';
import 'package:pic_share/data/repositories/notification/notification_repository.dart';
import 'package:pic_share/view_model/friend/friend_controller.dart';
import 'package:pic_share/view_model/home/home_controller.dart';
import 'package:pic_share/view_model/nav_bottom/nav_bottom_controller.dart';
import 'package:pic_share/view_model/notifications/notification_controller.dart';

class NotificationBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(
      () => NotificationController(
        notificationRepository: Get.find<NotificationRepository>(),
        friendController: Get.find<FriendController>(),
        homeController: Get.find<HomeController>(),
        navBottomController: Get.find<NavBottomController>(),
      ),
    );
  }
}
