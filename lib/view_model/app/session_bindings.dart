import 'package:get/get.dart';
import 'package:pic_share/view_model/app/session_controller.dart';

class SessionBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SessionController>(
      () => SessionController(),
    );
  }
}
