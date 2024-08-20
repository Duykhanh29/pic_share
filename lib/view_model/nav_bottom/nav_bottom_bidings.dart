import 'package:get/get.dart';
import 'package:pic_share/view_model/nav_bottom/nav_bottom_controller.dart';

class NavBottomBindinngs extends Bindings {
  @override
  void dependencies() {
    Get.put<NavBottomController>(
      NavBottomController(),
      permanent: true,
    );
  }
}
