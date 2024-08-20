import 'package:get/get.dart';
import 'package:pic_share/view_model/reacted_users/reacted_users_controller.dart';

class ReactedUsersBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReactedUsersController>(
      () => ReactedUsersController(),
    );
  }
}
