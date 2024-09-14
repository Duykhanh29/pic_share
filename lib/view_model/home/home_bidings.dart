import 'package:get/get.dart';
import 'package:pic_share/data/repositories/posts/post_repository.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
import 'package:pic_share/view_model/drawer/drawer_controller.dart';
import 'package:pic_share/view_model/home/home_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        postRepository: Get.find<PostRepository>(),
        authController: Get.find<AuthController>(),
        appDrawerController: Get.find<AppDrawerController>(),
      ),
    );
  }
}
