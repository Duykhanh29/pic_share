import 'package:flutter/material.dart';
import 'package:pic_share/app/constants/app_images.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/helper/image_cache_helper.dart';
import 'package:pic_share/data/models/user/user_summary_model.dart';

class UserViewsSheetWidget extends StatelessWidget {
  const UserViewsSheetWidget({
    super.key,
    required this.listViews,
  });
  final List<UserSummaryModel> listViews;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final user = listViews[index];
        return ListTile(
          onTap: () {},
          leading: user.urlAvatar != null
              ? ImageCacheHelper.avatarImage(url: user.urlAvatar!)
              : const CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage(AppImage.userEmptyAvatar),
                ),
          title: Text(
            user.name ?? "",
            style: AppTextStyles.commonTextStyle(),
          ),
        );
      },
      itemCount: listViews.length,
    );
  }
}
