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
  });

  final Conversation conversation;
  final Function(int, UserSummaryModel?)? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (onTap != null) {
          onTap!(conversation.id ?? 0, conversation.friend);
        }
      },
      contentPadding: const EdgeInsets.all(5),
      title: Text(
        conversation.friend?.name ?? "",
        style: AppTextStyles.headingTextStyle(),
      ),
      leading: conversation.friend?.urlAvatar != null
          ? ImageCacheHelper.avatarImage(
              url: conversation.friend!.urlAvatar!,
              height: MediaQuery.of(context).size.width * 0.1,
              width: MediaQuery.of(context).size.width * 0.1)
          : CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.05,
              backgroundImage: const AssetImage(AppImage.userEmptyAvatar),
            ),
      subtitle: Text(
        conversation.lastMessage?.text ?? "",
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.commonTextStyle(),
      ),
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
}
