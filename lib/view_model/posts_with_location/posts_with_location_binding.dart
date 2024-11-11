import 'package:get/get.dart';
import 'package:pic_share/data/repositories/posts/post_repository.dart';
import 'package:pic_share/view_model/posts_with_location/posts_with_location_controller.dart';

class PostsWithLocationBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostWithLocationController>(
      () => PostWithLocationController(
        postRepository: Get.find<PostRepository>(),
      ),
    );
  }
}
