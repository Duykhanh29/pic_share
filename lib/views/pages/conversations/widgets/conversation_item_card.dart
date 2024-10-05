import 'package:flutter/material.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_images.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/helper/image_cache_helper.dart';
import 'package:pic_share/data/models/user/user_summary_model.dart';
import 'package:pic_share/data/models/conversation/conversation.dart';
import 'package:pic_share/app/utils/date_utils.dart' as helper;

class ConversationItemCard extends StatelessWidget {
  const ConversationItemCard({
    super.key,
    required this.conversation,
    required this.onTap,
    required this.isMe,
  });

  final Conversation conversation;
  final Function(int, UserSummaryModel?)? onTap;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (onTap != null) {
          onTap!(conversation.id ?? 0, conversation.friend);
        }
      },
      contentPadding: const EdgeInsets.all(5),
      title: _buildName(context),
      leading: _buildAvatar(context),
      subtitle: _buildSubtitle(context),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            conversation.updatedAt != null
                ? helper.DateUtils.formatDateTimeToDateString(
                    conversation.updatedAt!)
                : "",
            style: AppTextStyles.smallTextStyle(),
          ),
          conversation.unreadCount != 0
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.warningColor,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  child: Text(
                    conversation.unreadCount.toString(),
                    style: AppTextStyles.smallTextStyle(),
                  ),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    String? avatar = isMe
        ? conversation.friend?.urlAvatar
        : conversation.currentUser?.urlAvatar;
    return avatar != null
        ? ImageCacheHelper.avatarImage(
            url: avatar,
            height: MediaQuery.of(context).size.width * 0.1,
            width: MediaQuery.of(context).size.width * 0.1)
        : CircleAvatar(
            radius: MediaQuery.of(context).size.width * 0.05,
            backgroundImage: const AssetImage(AppImage.userEmptyAvatar),
          );
  }

  Widget _buildName(BuildContext context) {
    String? name =
        isMe ? conversation.friend?.name : conversation.currentUser?.name;
    return Text(
      name ?? "",
      style: AppTextStyles.headingTextStyle(),
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    String msg = conversation.lastMessage?.text ?? "";
    String? name =
        isMe ? conversation.friend?.name : conversation.currentUser?.name;
    String message = isMe ? msg : "$name: $msg";
    return Text(
      message,
      overflow: TextOverflow.ellipsis,
      style: AppTextStyles.commonTextStyle(),
    );
  }
}
