import 'package:get/get.dart';
import 'package:pic_share/data/repositories/friend/friend_repository.dart';
import 'package:pic_share/data/repositories/posts/post_repository.dart';
import 'package:pic_share/data/repositories/user/user_repository.dart';
import 'package:pic_share/view_model/friend/friend_controller.dart';
import 'package:pic_share/view_model/friend_profile/friend_profile_controller.dart';

class FriendProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FriendProfileController>(
      () => FriendProfileController(
        friendRepository: Get.find<FriendRepository>(),
        userRepository: Get.find<UserRepository>(),
        postRepository: Get.find<PostRepository>(),
        friendController: Get.find<FriendController>(),
      ),
    );
  }
}
