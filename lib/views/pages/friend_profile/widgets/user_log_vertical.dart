import 'package:flutter/material.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserLogVerticalWidget extends StatelessWidget {
  const UserLogVerticalWidget(
      {super.key,
      required this.postCount,
      required this.viewCount,
      required this.likeCount});
  final int postCount;
  final int viewCount;
  final int likeCount;
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildItem(t.posts, postCount),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Divider(
            thickness: 0.1,
            color: AppColors.darkBorderColor,
          ),
        ),
        _buildItem(t.views, viewCount),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Divider(
            thickness: 0.1,
            color: AppColors.darkBorderColor,
          ),
        ),
        _buildItem(t.likes, likeCount),
      ],
    );
  }

  Widget _buildItem(String title, int value) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyles.smallTextStyle(),
        ),
        const SizedBox(
          width: 25,
        ),
        Text(
          value.toString(),
          style: AppTextStyles.headingTextStyle(),
        ),
      ],
    );
  }
}
