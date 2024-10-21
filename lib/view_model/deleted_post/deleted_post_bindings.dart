import 'package:get/get.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
import 'package:pic_share/view_model/deleted_post/deleted_post_controller.dart';

class DeletedPostBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeletedPostController>(
      () => DeletedPostController(
        authController: Get.find<AuthController>(),
      ),
    );
  }
}
