import 'package:get/get.dart';
import 'package:pic_share/view_model/verify/verify_controller.dart';

class VerifyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyController>(() => VerifyController());
  }
}
