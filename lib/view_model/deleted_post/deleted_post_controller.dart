import 'package:get/get.dart';
import 'package:pic_share/app/constants/strings.dart';
import 'package:pic_share/data/models/post/deleted_post.dart';
import 'package:pic_share/data/models/user/user_model.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';

class DeletedPostController extends GetxController {
  DeletedPostController({required this.authController}) {
    if (Get.arguments != null) {
      deletedPost.value = Get.arguments[Strings.deletedPost] as DeletedPost;
    }
  }
  AuthController authController;
  UserModel? get currentUser => authController.getCurrentUser;
  Rx<DeletedPost?> deletedPost = Rx<DeletedPost?>(null);
}
