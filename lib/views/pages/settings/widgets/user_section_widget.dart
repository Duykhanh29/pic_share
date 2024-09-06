import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/config/app_config.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_images.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/helper/image_cache_helper.dart';
import 'package:pic_share/view_model/settings/settings_controller.dart';

class UserSectionWidget extends GetView<SettingsController> {
  const UserSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: controller.onNavToProfile,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.appBorder),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.selectedColor),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: controller.currentUser?.urlAvatar != null
                  ? ImageCacheHelper.avatarImage(
                      url: controller.currentUser!.urlAvatar!,
                      width: MediaQuery.of(context).size.height * 0.06,
                      height: MediaQuery.of(context).size.height * 0.06,
                    )
                  : CircleAvatar(
                      radius: MediaQuery.of(context).size.height * 0.03,
                      backgroundImage:
                          const AssetImage(AppImage.userEmptyAvatar),
                    ),
            ),
            const SizedBox(width: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.currentUser?.name ?? "You haven't set name",
                  style: AppTextStyles.headingTextStyle(),
                ),
                Text(
                  controller.currentUser?.email ?? "You haven't set email",
                  style: AppTextStyles.commonTextStyle(),
                  overflow: TextOverflow.clip,
                ),
                Text(
                  controller.currentUser?.createdAt ?? "",
                  style: AppTextStyles.commonTextStyle()
                      .copyWith(color: AppColors.darkBorderColor),
                ),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: controller.onNavToEditProfile,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: 26,
                width: 26,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.orange),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.edit,
                  size: 16,
                  color: AppColors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
