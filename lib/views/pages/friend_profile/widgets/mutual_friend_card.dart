import 'package:flutter/material.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/data/models/user/user_summary_model.dart';
import 'package:pic_share/views/widgets/avatar_widget.dart';

class MutualFriendCard extends StatelessWidget {
  const MutualFriendCard(
      {super.key, required this.friend, required this.onTap});
  final UserSummaryModel friend;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            _buildAvatar(context),
            const SizedBox(width: 10),
            _buildName(),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return AvatarWidget(urlAvatar: friend.urlAvatar);
  }

  Widget _buildName() {
    return Text(
      friend.name ?? "",
      style: AppTextStyles.commonTextStyle()
          .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
    );
  }
}
