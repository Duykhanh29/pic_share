import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/data/models/comment/comment.dart';
import 'package:pic_share/data/models/comment/reply.dart';
import 'package:pic_share/app/constants/app_images.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/data/models/user/user_model.dart';
import 'package:pic_share/data/models/user/user_summary_model.dart';

class CommentSection extends StatefulWidget {
  const CommentSection({
    super.key,
    required this.comment,
    this.onReply,
    required this.currentUser,
    this.onUserClick,
  });
  final Comment comment;
  final Function()? onReply;
  final UserModel? currentUser;
  final Function(UserSummaryModel? user)? onUserClick;

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  int index = 1;

  List<Reply> get visibleReplies {
    int end = index * 3;
    if (end > widget.comment.listReply.length) {
      end = widget.comment.listReply.length;
    }
    return widget.comment.listReply.sublist(0, end);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: CommentTreeWidget<Comment, Reply>(
        widget.comment,
        visibleReplies,
        treeThemeData: TreeThemeData(
            lineColor: Colors.green[500]!,
            lineWidth: widget.comment.listReply.isEmpty ? 0 : 3),
        avatarRoot: (context, data) => PreferredSize(
          preferredSize: const Size.fromRadius(18),
          child: _buildAvatar(data.user),
        ),
        avatarChild: (context, data) => PreferredSize(
          preferredSize: const Size.fromRadius(12),
          child: _buildAvatar(data.user),
        ),
        contentChild: (context, data) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.currentUser?.id == data.user?.id
                          ? t.you
                          : data.user?.name ?? "",
                      style: AppTextStyles.headingTextStyle(),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      '${data.content}',
                      style: AppTextStyles.commonTextStyle(),
                    ),
                  ],
                ),
              ),
              DefaultTextStyle(
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.grey[700], fontWeight: FontWeight.bold),
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          // SizedBox(
                          //   width: 8,
                          // ),
                          // Text('Like'),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: widget.onReply,
                            child: Text(
                              t.reply,
                              style: AppTextStyles.smallTextStyle().copyWith(
                                color: AppColors.thirdColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (widget.comment.listReply.length > index * 3 &&
                          visibleReplies.last.id == data.id)
                        InkWell(
                          onTap: () {
                            setState(() {
                              index++;
                            });
                          },
                          child: Text(
                            t.seeMore,
                            style: AppTextStyles.seeMoreTextStyle()
                                .copyWith(fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        contentRoot: (context, data) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.currentUser?.id == data.user?.id
                          ? t.you
                          : data.user?.name ?? "",
                      style: AppTextStyles.headingTextStyle(),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      '${data.content}',
                      style: AppTextStyles.commonTextStyle(),
                    ),
                  ],
                ),
              ),
              DefaultTextStyle(
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.grey[700], fontWeight: FontWeight.bold),
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    children: [
                      // SizedBox(
                      //   width: 8,
                      // ),
                      // Text('Like'),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: widget.onReply,
                        child: Text(
                          t.reply,
                          style: AppTextStyles.smallTextStyle().copyWith(
                            color: AppColors.thirdColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildAvatar(UserSummaryModel? user) {
    return InkWell(
      onTap: () {
        widget.onUserClick?.call(user);
      },
      child: user?.urlAvatar != null
          ? CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(user!.urlAvatar!),
            )
          : const CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey,
              backgroundImage: AssetImage(
                AppImage.userEmptyAvatar,
              ),
            ),
    );
  }
}
