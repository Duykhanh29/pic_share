import 'package:flutter/material.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_images.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/helper/image_cache_helper.dart';
import 'package:pic_share/data/enums/friend_status.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/data/models/user/friend.dart';

class FriendCard extends StatelessWidget {
  const FriendCard({
    super.key,
    this.isSent,
    this.onChatClick,
    this.onAccepttClick,
    this.onRejectClick,
    required this.onItemClick,
    required this.friend,
    required this.isMe,
  });
  final Friend friend;
  final bool? isSent;
  final void Function(int)? onChatClick;
  final Future<void> Function(int)? onAccepttClick;
  final Future<void> Function(int)? onRejectClick;
  final void Function(int) onItemClick;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () {
        onItemClick( friend.id);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            _buildAvatar(context),
            const SizedBox(width: 10),
            _buildName(),
            const Spacer(),
            _buildButtons(t),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return friend.avatar != null
        ? ImageCacheHelper.avatarImage(
            url: friend.avatar!,
            width: MediaQuery.of(context).size.height * 0.08,
            height: MediaQuery.of(context).size.height * 0.08)
        : CircleAvatar(
            radius: MediaQuery.of(context).size.height * 0.04,
            backgroundImage: const AssetImage(
              AppImage.userEmptyAvatar,
            ),
          );
  }

  Widget _buildName() {
    return Text(
      friend.name ?? "",
      style: AppTextStyles.commonTextStyle()
          .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildButtons(AppLocalizations t) {
    return Visibility(
      visible: friend.status == FriendStatus.friend,
      replacement: _buildNotFriendStatus(t),
      child: Row(
        children: [
          IconButton.outlined(
            onPressed: () {
              if (onChatClick != null) {
                onChatClick!(friend.id);
              }
            },
            icon: const Icon(Icons.message_outlined),
          ),
          IconButton.outlined(
            onPressed: () async {
              if (onRejectClick != null) {
                await onRejectClick!(friend.id);
              }
            },
            icon: const Icon(Icons.person_add_disabled),
          ),
        ],
      ),
    );
  }

  Widget _buildNotFriendStatus(AppLocalizations t) {
    return Visibility(
      visible: isSent == false,
      replacement: GestureDetector(
        onTap: () async {
          if (onRejectClick != null) {
            await onRejectClick!(friend.id);
          }
        },
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.darkBorderColor,
          ),
          child: Text(
            t.recall,
            style: AppTextStyles.commonTextStyle()
                .copyWith(color: AppColors.white),
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton.filled(
            color: AppColors.warningColor,
            onPressed: () async {
              if (onRejectClick != null) {
                await onRejectClick!(friend.id);
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
              if (onAccepttClick != null) {
                await onAccepttClick!(friend.id);
              }
            },
            icon: Icon(
              Icons.done,
              color: AppColors.white,
            ),
          )
        ],
      ),
    );
  }
}
