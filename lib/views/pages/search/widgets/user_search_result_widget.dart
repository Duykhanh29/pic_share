import 'package:flutter/material.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_images.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/helper/image_cache_helper.dart';
import 'package:pic_share/data/enums/user_relationship.dart';
import 'package:pic_share/data/models/user/user_friendship_model.dart';

class UserSearchResultWidget extends StatelessWidget {
  const UserSearchResultWidget(
      {super.key,
      required this.userSummaryModel,
      this.onChatTap,
      required this.onTap,
      this.onTapAddFriend,
      this.onAcceptFriend,
      this.onRejectFriend});
  final UserFriendShipModel userSummaryModel;
  final void Function(int) onTap;
  final Future<void> Function(int)? onTapAddFriend;
  final void Function(int)? onChatTap;
  final Future<void> Function(int)? onAcceptFriend;
  final Future<void> Function(int)? onRejectFriend;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.appBorder),
        ),
        child: Row(
          children: [
            userSummaryModel.user.urlAvatar != null
                ? ImageCacheHelper.avatarImage(
                    url: userSummaryModel.user.urlAvatar!,
                    width: MediaQuery.of(context).size.height * 0.08,
                    height: MediaQuery.of(context).size.height * 0.08)
                : CircleAvatar(
                    radius: MediaQuery.of(context).size.height * 0.04,
                    backgroundImage: const AssetImage(
                      AppImage.userEmptyAvatar,
                    ),
                  ),
            const SizedBox(
              width: 20,
            ),
            Text(
              userSummaryModel.user.name ?? "",
              style: AppTextStyles.commonTextStyle()
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            _buildButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildButton() {
    if (userSummaryModel.relationship == UserRelationship.notFriend) {
      return IconButton.outlined(
        onPressed: () async {
          if (onTapAddFriend != null) {
            await onTapAddFriend!(userSummaryModel.user.id?.toInt() ?? 0);
          }
        },
        icon: const Icon(Icons.person_add_alt_1),
      );
    } else if (userSummaryModel.relationship == UserRelationship.friend) {
      return IconButton.outlined(
        onPressed: () {
          if (onChatTap != null) {
            onChatTap!(userSummaryModel.user.id?.toInt() ?? 0);
          }
        },
        icon: const Icon(Icons.chat),
      );
    } else if (userSummaryModel.relationship == UserRelationship.sent) {
      return IconButton.outlined(
        onPressed: () async {
          if (onRejectFriend != null) {
            await onRejectFriend!(userSummaryModel.user.id?.toInt() ?? 0);
          }
        },
        icon: const Icon(Icons.cancel),
      );
    } else {
      return Row(
        children: [
          IconButton.filled(
            color: AppColors.warningColor,
            onPressed: () async {
              if (onRejectFriend != null) {
                await onRejectFriend!(userSummaryModel.user.id?.toInt() ?? 0);
              }
            },
            icon: Icon(
              Icons.clear,
              color: AppColors.white,
            ),
          ),
          IconButton.filled(
            color: AppColors.secondaryColor,
            onPressed: () async {
              if (onAcceptFriend != null) {
                await onAcceptFriend!(userSummaryModel.user.id?.toInt() ?? 0);
              }
            },
            icon: Icon(
              Icons.done,
              color: AppColors.white,
            ),
          )
        ],
      );
    }
  }
}
