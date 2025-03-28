import 'package:flutter/material.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/data/enums/user_relationship.dart';
import 'package:pic_share/data/models/user/user_friendship_model.dart';
import 'package:pic_share/views/widgets/avatar_widget.dart';

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
  final Future<void> Function({required int userID, required int id})?
      onAcceptFriend;
  final Future<void> Function({required int userID, required int id})?
      onRejectFriend;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap.call(userSummaryModel.user.id?.toInt() ?? 0);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.appBorder),
        ),
        child: Row(
          children: [
            _buildAvatar(context),
            const SizedBox(
              width: 20,
            ),
            _buildName(),
            const Spacer(),
            _buildButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return AvatarWidget(
      urlAvatar: userSummaryModel.user.urlAvatar,
    );
  }

  Widget _buildName() {
    return Text(
      userSummaryModel.user.name ?? "",
      style: AppTextStyles.commonTextStyle()
          .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
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
      return Row(
        children: [
          IconButton.outlined(
            onPressed: () {
              if (onChatTap != null) {
                onChatTap!(userSummaryModel.user.id?.toInt() ?? 0);
              }
            },
            icon: const Icon(Icons.chat),
          ),
          IconButton.outlined(
            onPressed: () async {
              await onReject();
            },
            icon: const Icon(Icons.person_add_disabled),
          ),
        ],
      );
    } else if (userSummaryModel.relationship == UserRelationship.sent) {
      return IconButton.outlined(
        onPressed: () async {
          await onReject();
        },
        icon: const Icon(Icons.cancel),
      );
    } else {
      return Row(
        children: [
          IconButton.filled(
            color: AppColors.warningColor,
            onPressed: () async {
              await onReject();
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
                await onAcceptFriend!(
                    userID: userSummaryModel.user.id?.toInt() ?? 0,
                    id: userSummaryModel.id);
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

  Future<void> onReject() async {
    if (onRejectFriend != null) {
      await onRejectFriend!(
          userID: userSummaryModel.user.id?.toInt() ?? 0,
          id: userSummaryModel.id);
    }
  }
}
