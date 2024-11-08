import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/strings.dart';
import 'package:pic_share/app/helper/snack_bar_helper.dart';
import 'package:pic_share/data/models/comment/comment.dart';
import 'package:pic_share/data/models/comment/reply.dart';
import 'package:pic_share/data/models/user/user_model.dart';
import 'package:pic_share/data/models/user/user_summary_model.dart';
import 'package:pic_share/data/repositories/comments/comment_repository.dart';
import 'package:pic_share/routes/app_pages.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';

class CommentsController extends GetxController {
  CommentRepository commentRepository;
  AuthController authController;

  CommentsController({
    required this.commentRepository,
    required this.authController,
  }) {
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

  // getter
  UserModel? get currentUser => authController.getCurrentUser;
  late UserSummaryModel userSummary;

  @override
  void onInit() async {
    commentController = TextEditingController();
    userSummary = UserSummaryModel(
      id: currentUser?.id ?? 0,
      name: currentUser?.name,
      urlAvatar: currentUser?.urlAvatar,
      userCode: currentUser?.userCode,
    );
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
      final response = await commentRepository.getComments(postId.value);
      if (response.isSuccess) {
        final list = response.data ?? [];
        listComments.assignAll(list);
      } else {
        SnackbarHelper.errorSnackbar(response.message ?? '');
      }
    } catch (e) {
      debugPrint('Something went wrong: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendComment(String text) async {
    isLoading.value = true;
    try {
      if (text.isNotEmpty) {
        Comment tempComment = Comment(
          content: text,
          createdAt: DateTime.now().toIso8601String(),
          user: userSummary,
          id: 0,
        );
        listComments.add(tempComment);
        isLoading.value = false;
        commentController.clear();
        final response =
            await commentRepository.addComment(id: postId.value, content: text);
        if (response.isSuccess) {
          final comment = response.data;
          if (comment != null) {
            // listComments.add(comment);
          }
        } else {
          SnackbarHelper.errorSnackbar(response.message ?? '');
        }

        // commentController.clear();
      }
    } catch (e) {
      debugPrint('Something went wrong: $e');
      SnackbarHelper.errorSnackbar(e.toString());
    } finally {
      isLoading.value = false;
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
    isLoading.value = true;
    try {
      if (text.isNotEmpty) {
        Reply tempReply = Reply(
          content: text,
          id: 0,
          user: userSummary,
          createdAt: DateTime.now().toIso8601String(),
        );
        listComments
            .firstWhere((element) => element.id == commentId)
            .listReply
            .add(tempReply);
        isLoading.value = false;
        commentController.clear();
        final response = await commentRepository.addReply(
            cmtId: commentId, content: text, id: postId.value);
        if (response.isSuccess) {
          final reply = response.data;
          if (reply != null) {
            // listComments
            //     .firstWhere((element) => element.id == commentId)
            //     .listReply
            //     .add(reply);
          } else {
            SnackbarHelper.errorSnackbar(response.message ?? '');
          }
        }
      }
    } catch (e) {
      debugPrint('Something went wrong: $e');
      SnackbarHelper.errorSnackbar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void onClickReplyTo(int index) {
    final value = listComments[index].id;
    commentId.value = value ?? 0;
    focusNode.requestFocus();
  }

  void onUserClick(UserSummaryModel? user) {
    if (user == null) return;
    if (user.id == currentUser?.id) {
      Get.toNamed(Routes.profile);
    } else {
      Get.toNamed(Routes.friendProfile, arguments: {
        Strings.userSummary: user,
      });
    }
  }
}
