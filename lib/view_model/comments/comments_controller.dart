import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/strings.dart';
import 'package:pic_share/data/models/comment/comment.dart';
import 'package:pic_share/data/repositories/comments/comment_repository.dart';

class CommentsController extends GetxController {
  CommentRepository commentRepository;

  CommentsController({required this.commentRepository}) {
    if (Get.arguments != null) {
      final arguments = Get.arguments as Map<String, dynamic>;

      postId.value = arguments[Strings.postId] as int;
    } else {}
  }

  Rx<int> postId = 0.obs;
  RxList<Comment> listComments = RxList<Comment>([]);
  RxBool isLoading = true.obs;
  late TextEditingController commentController;

  @override
  void onInit() async {
    commentController = TextEditingController();
    await fetchComments();
    super.onInit();
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  Future<void> fetchComments() async {
    isLoading.value = true;
    try {
      listComments.value = await commentRepository.getComments(postId.value);
    } catch (e) {
      debugPrint('Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendComment(String text) async {
    try {
      if (text.isNotEmpty) {
        final comment =
            await commentRepository.addComment(id: postId.value, content: text);
        if (comment != null) {
          listComments.add(comment);
        }
      }
    } catch (e) {
      debugPrint('Something went wrong: $e');
    }
  }
}
