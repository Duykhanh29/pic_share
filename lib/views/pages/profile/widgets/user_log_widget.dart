import 'package:flutter/material.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserLogWidget extends StatelessWidget {
  const UserLogWidget(
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildItem(t.posts, postCount),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: VerticalDivider(
            width: 1,
            thickness: 0.5,
            color: AppColors.darkBorderColor,
          ),
        ),
        _buildItem(t.views, viewCount),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: VerticalDivider(
            width: 1,
            thickness: 0.5,
            color: AppColors.darkBorderColor,
          ),
        ),
        _buildItem(t.likes, likeCount),
      ],
    );
  }

  Widget _buildItem(String title, int value) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: AppTextStyles.headingTextStyle(),
        ),
        Text(
          title,
          style: AppTextStyles.smallTextStyle(),
        ),
      ],
    );
  }
}
