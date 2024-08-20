import 'package:get/get.dart';
import 'package:pic_share/view_model/new_post/new_post_controller.dart';

class NewPostBidings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewPostController>(
      () => NewPostController(),
    );
  }
}
