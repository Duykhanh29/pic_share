import 'package:get/get.dart';
import 'package:pic_share/view_model/comments/comments_controller.dart';

class CommentsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommentsController>(
      () => CommentsController(),
    );
  }
}
