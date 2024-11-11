import 'package:get/get.dart';
import 'package:pic_share/data/repositories/posts/post_repository.dart';
import 'package:pic_share/data/repositories/user/user_repository.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
import 'package:pic_share/view_model/profile/profile_controller.dart';

class ProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(
      () => ProfileController(
        authController: Get.find<AuthController>(),
        postRepository: Get.find<PostRepository>(),
        userRepository: Get.find<UserRepository>(),
      ),
    );
  }
}
