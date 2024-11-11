import 'package:get/get.dart';
import 'package:pic_share/app/services/location_service.dart';
import 'package:pic_share/data/repositories/posts/post_repository.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
import 'package:pic_share/view_model/friend/friend_controller.dart';
import 'package:pic_share/view_model/new_post/new_post_controller.dart';

class NewPostBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewPostController>(
      () => NewPostController(
        postRepository: Get.find<PostRepository>(),
        friendController: Get.find<FriendController>(),
        authController: Get.find<AuthController>(),
        locationService: Get.find<LocationService>(),
      ),
    );
  }
}
