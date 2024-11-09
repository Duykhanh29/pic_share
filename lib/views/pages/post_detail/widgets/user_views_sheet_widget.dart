import 'package:flutter/material.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/data/models/user/user_summary_model.dart';
import 'package:pic_share/views/widgets/avatar_widget.dart';

class UserViewsSheetWidget extends StatelessWidget {
  const UserViewsSheetWidget({
    super.key,
    required this.listViews,
  });
  final List<UserSummaryModel> listViews;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final user = listViews[index];
        return ListTile(
          onTap: () {},
          leading: AvatarWidget(
            urlAvatar: user.urlAvatar,
            height: size * 0.05,
            width: size * 0.05,
            radius: size * 0.025,
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
