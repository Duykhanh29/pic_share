import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/data/models/comment/comment.dart';
import 'package:pic_share/data/models/comment/reply.dart';

class CommentSection extends StatelessWidget {
  const CommentSection({super.key, required this.comment});
  final Comment comment;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: CommentTreeWidget<Comment, Reply>(
        comment,
        comment.listReply,
        treeThemeData:
            TreeThemeData(lineColor: Colors.green[500]!, lineWidth: 3),
        avatarRoot: (context, data) => PreferredSize(
          preferredSize: const Size.fromRadius(18),
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(data.user!.urlAvatar!),
          ),
        ),
        avatarChild: (context, data) => PreferredSize(
          preferredSize: const Size.fromRadius(12),
          child: CircleAvatar(
            radius: 12,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(data.user!.urlAvatar!),
          ),
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
                      data.user?.name ?? "",
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
                child: const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      Text('Like'),
                      SizedBox(
                        width: 24,
                      ),
                      Text('Reply'),
                    ],
                  ),
                ),
              )
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
                      data.user?.name ?? "",
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
                style: Theme.of(context).textTheme.caption!.copyWith(
                    color: Colors.grey[700], fontWeight: FontWeight.bold),
                child: const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      Text('Like'),
                      SizedBox(
                        width: 24,
                      ),
                      Text('Reply'),
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
}
