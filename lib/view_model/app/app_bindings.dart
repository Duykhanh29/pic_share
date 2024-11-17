import 'package:get/get.dart';
import 'package:pic_share/view_model/app/app_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppController>(
      () => AppController(),
    );
  }
}
