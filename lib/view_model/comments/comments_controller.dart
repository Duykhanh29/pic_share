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
  Rx<int> commentId = 0.obs;
  FocusNode focusNode = FocusNode();

  @override
  void onInit() async {
    commentController = TextEditingController();
    await fetchComments();
    super.onInit();
  }

  @override
  void dispose() {
    commentId.value = 0;
    focusNode.unfocus();
    commentController.dispose();
    super.dispose();
  }

  Future<void> fetchComments() async {
    isLoading.value = true;
    try {
      final list = await commentRepository.getComments(postId.value);
      listComments.assignAll(list);
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
        commentController.clear();
      }
    } catch (e) {
      debugPrint('Something went wrong: $e');
    }
  }

  Future<void> onSubmit(String text) async {
    focusNode.unfocus();
    if (commentId.value != 0) {
      await replyToComment(commentId.value, text);
      commentId.value = 0;
    } else {
      await sendComment(text);
    }
  }

  Future<void> replyToComment(int commentId, String text) async {
    try {
      if (text.isNotEmpty) {
        final reply = await commentRepository.addReply(
            cmtId: commentId, content: text, id: postId.value);
        if (reply != null) {
          listComments
              .firstWhere((element) => element.id == commentId)
              .listReply
              .add(reply);
        }
        commentController.clear();
      }
    } catch (e) {
      debugPrint('Something went wrong: $e');
    }
  }

  void onClickReplyTo(int index) {
    final value = listComments[index].id;
    commentId.value = value ?? 0;
    focusNode.requestFocus();
  }
}
