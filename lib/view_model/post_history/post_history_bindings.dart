import 'package:get/get.dart';
import 'package:pic_share/data/repositories/posts/post_repository.dart';
import 'package:pic_share/view_model/post_history/post_history_controller.dart';
import 'package:pic_share/view_model/profile/profile_controller.dart';

class PostHistoryBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostHistoryController>(
      () => PostHistoryController(
        postRepository: Get.find<PostRepository>(),
        profileController: Get.find<ProfileController>(),
      ),
    );
  }
}
