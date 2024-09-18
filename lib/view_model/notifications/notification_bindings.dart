import 'package:get/get.dart';
import 'package:pic_share/data/repositories/notification/notification_repository.dart';
import 'package:pic_share/view_model/notifications/notification_controller.dart';

class NotificationBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(
      () => NotificationController(
        notificationRepository: Get.find<NotificationRepository>(),
      ),
    );
  }
}
