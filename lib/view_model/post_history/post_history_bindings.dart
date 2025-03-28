import 'package:get/get.dart';
import 'package:pic_share/data/repositories/posts/post_repository.dart';
import 'package:pic_share/data/repositories/user/user_repository.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
import 'package:pic_share/view_model/post_history/post_history_controller.dart';
import 'package:pic_share/view_model/profile/profile_controller.dart';

class PostHistoryBindings extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ProfileController>()) {
      Get.lazyPut(() => ProfileController(
          authController: Get.find<AuthController>(),
          postRepository: Get.find<PostRepository>(),
          userRepository: Get.find<UserRepository>()));
    }
    final profileController = Get.find<ProfileController>();

    Get.lazyPut<PostHistoryController>(
      () => PostHistoryController(
        postRepository: Get.find<PostRepository>(),
        profileController: profileController,
      ),
    );
  }
}
