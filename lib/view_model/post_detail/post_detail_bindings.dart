import 'package:get/get.dart';
import 'package:pic_share/data/repositories/posts/post_repository.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
import 'package:pic_share/view_model/post_detail/post_detail_controller.dart';

class PostDetailBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostDetailController>(
      () => PostDetailController(
        postRepository: Get.find<PostRepository>(),
        authController: Get.find<AuthController>(),
      ),
    );
  }
}
