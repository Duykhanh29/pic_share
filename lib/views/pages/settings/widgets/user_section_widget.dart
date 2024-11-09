import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_images.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/helper/image_cache_helper.dart';
import 'package:pic_share/view_model/settings/settings_controller.dart';
import 'package:pic_share/app/utils/date_utils.dart' as helper;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserSectionWidget extends GetView<SettingsController> {
  const UserSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return InkWell(
      onTap: controller.onNavToProfile,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.appBorder),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Obx(
          () => Row(
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
                child: controller.currentUser.value?.urlAvatar != null
                    ? ImageCacheHelper.avatarImage(
                        url: controller.currentUser.value!.urlAvatar!,
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
                    controller.currentUser.value?.name ?? t.youHaveNoName,
                    style: AppTextStyles.headingTextStyle(),
                  ),
                  Text(
                    controller.currentUser.value?.email ?? "",
                    style: AppTextStyles.commonTextStyle(),
                    overflow: TextOverflow.clip,
                  ),
                  Text(
                    controller.currentUser.value?.createdAt != null
                        ? helper.DateUtils.stringToDate(
                            controller.currentUser.value!.createdAt!)
                        : "",
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
      ),
    );
  }
}
