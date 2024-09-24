import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/view_model/settings/settings_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/views/pages/settings/widgets/item_card.dart';

class GeneralSettingsSection extends GetView<SettingsController> {
  const GeneralSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.appBorder),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            height: 2,
          ),
          ItemCard(
            backgroundColor: AppColors.blue,
            icon: Icons.language,
            iconColor: AppColors.white,
            onTap: controller.onNavToLanguage,
            title: t.language,
            // subtitle: controller.language,
          ),
          Divider(
            thickness: 0.4,
            color: AppColors.lightBorderColor,
          ),
          ItemCard(
            backgroundColor: AppColors.blue,
            icon: Icons.notifications_none_outlined,
            iconColor: AppColors.white,
            onTap: controller.onNavNotificationSettings,
            title: t.notification,
          ),
          const SizedBox(
            height: 2,
          ),
        ],
      ),
    );
  }
}
