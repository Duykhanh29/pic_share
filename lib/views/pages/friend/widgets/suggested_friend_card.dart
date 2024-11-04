import 'package:flutter/material.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_images.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/helper/image_cache_helper.dart';
import 'package:pic_share/data/models/user/user_summary_model.dart';

class SuggestedFriendCard extends StatelessWidget {
  const SuggestedFriendCard({
    super.key,
    required this.user,
    required this.onTap,
    required this.onMakeFriend,
  });
  final UserSummaryModel? user;
  final Function(UserSummaryModel?) onTap;
  final Function(int) onMakeFriend;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(user);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
    return user?.urlAvatar != null
        ? ImageCacheHelper.avatarImage(
            url: user!.urlAvatar!,
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
      user?.name ?? "",
      style: AppTextStyles.commonTextStyle()
          .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildButton() {
    return IconButton.outlined(
      onPressed: () async {
        await onMakeFriend(user?.id?.toInt() ?? 0);
      },
      icon: const Icon(Icons.person_add_alt_1),
    );
  }
}
