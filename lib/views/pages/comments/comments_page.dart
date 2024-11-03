import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/custom/app_bar_custom.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/view_model/comments/comments_controller.dart';
import 'package:pic_share/views/pages/comments/widgets/comment_section.dart';
import 'package:pic_share/views/widgets/keyboard_dismiss.dart';
import 'package:pic_share/views/widgets/loading_widget.dart';

class CommentsPage extends GetView<CommentsController> {
  const CommentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return KeyboardDismiss(
      child: Scaffold(
        appBar: CustomAppBar(title: t.comment).show(),
        body: Obx(
          () => Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    _buildListComment(),
                    _buildInputField(t),
                  ],
                ),
              ),
              if (controller.isLoading.value) const LoadingWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListComment() {
    return Expanded(
      child: Obx(
        () => ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Obx(
              () => CommentSection(
                comment: controller.listComments[index],
                onReply: () {
                  controller.onClickReplyTo(index);
                },
                currentUser: controller.currentUser,
                onUserClick: controller.onUserClick,
              ),
            );
          },
          itemCount: controller.listComments.length,
        ),
      ),
    );
  }

  Widget _buildInputField(AppLocalizations t) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Obx(
        () => TextField(
          focusNode: controller.focusNode,
          // onSubmitted: controller.onSubmit,
          controller: controller.commentController,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            hintText:
                controller.commentId.value == 0 ? t.writeAComment : t.replyTo,
            suffixIcon: GestureDetector(
              onTap: () async {
                await controller.onSubmit(controller.commentController.text);
              },
              child: Container(
                padding: const EdgeInsets.all(2),
                margin: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 227, 232, 235)),
                child: Icon(
                  Icons.send,
                  color: AppColors.backgroundColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
