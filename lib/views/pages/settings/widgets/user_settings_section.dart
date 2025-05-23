import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/view_model/settings/settings_controller.dart';
import 'package:pic_share/views/pages/settings/widgets/item_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserSettingsSection extends GetView<SettingsController> {
  const UserSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.appBorder),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            height: 2,
          ),
          ItemCard(
            backgroundColor: AppColors.blue,
            icon: Icons.people,
            iconColor: AppColors.white,
            onTap: controller.onNavToFriend,
            title: t.friends,
          ),
          Divider(
            thickness: 0.4,
            color: AppColors.lightBorderColor,
          ),
          ItemCard(
            backgroundColor: AppColors.blue,
            icon: Icons.qr_code_outlined,
            iconColor: AppColors.white,
            onTap: controller.onNavToUserCode,
            title: t.searchForUserCode,
          ),
          Divider(
            thickness: 0.4,
            color: AppColors.lightBorderColor,
          ),
          ItemCard(
            backgroundColor: AppColors.blue,
            icon: Icons.history,
            iconColor: AppColors.white,
            onTap: controller.onNavToHistory,
            title: t.history,
          ),
          // Divider(
          //   thickness: 0.4,
          //   color: AppColors.lightBorderColor,
          // ),
          // ItemCard(
          //   backgroundColor: AppColors.blue,
          //   icon: Icons.location_on,
          //   iconColor: AppColors.white,
          //   onTap: controller.onNavToPostsWithLocation,
          //   title: t.postsWithLocation,
          // ),
          Divider(
            thickness: 0.4,
            color: AppColors.lightBorderColor,
          ),
          ItemCard(
            backgroundColor: AppColors.blue,
            icon: Icons.location_on,
            iconColor: AppColors.white,
            onTap: controller.onNavToPostsLocation,
            title: t.postsWithLocation,
          ),
          const SizedBox(
            height: 2,
          ),
        ],
      ),
    );
  }
}
