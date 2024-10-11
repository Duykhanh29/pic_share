import 'package:get/get.dart';
import 'package:pic_share/data/repositories/posts/post_repository.dart';
import 'package:pic_share/view_model/posts_location/posts_location_controller.dart';

class PostsLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostsLocationController>(
      () => PostsLocationController(
        postRepository: Get.find<PostRepository>(),
      ),
    );
  }
}
