import 'package:get/get.dart';
import 'package:pic_share/routes/app_pages.dart';

class HomeController extends GetxController {
  void onNavToNotification() {
    Get.toNamed(Routes.notification);
  }

  void onNavToGridPostView() {
    Get.toNamed(Routes.gridPostView);
  }
}
