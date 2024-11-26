import 'package:get/get.dart';
import 'package:pic_share/app/services/local_storage_service.dart';
import 'package:pic_share/app/services/notification_service.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
import 'package:pic_share/view_model/friend/friend_controller.dart';
import 'package:pic_share/view_model/settings/settings_controller.dart';

class SettingsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(
      () => SettingsController(
        authController: Get.find<AuthController>(),
        friendController: Get.find<FriendController>(),
        localStorageService: Get.find<LocalStorageService>(),
        notificationsService: Get.find<NotificationsService>(),
      ),
    );
  }
}
