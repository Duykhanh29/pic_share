import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/helper/dialog_helper.dart';
import 'package:pic_share/view_model/settings/settings_controller.dart';
import 'package:pic_share/views/pages/settings/widgets/item_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountSettingsSection extends GetView<SettingsController> {
  const AccountSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.warningColor.withOpacity(0.6)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            height: 2,
          ),
          ItemCard(
            backgroundColor: AppColors.dardSecondaryColor,
            icon: Icons.security_outlined,
            iconColor: AppColors.white,
            onTap: controller.onNavToSecurity,
            title: t.security,
          ),
          Divider(
            thickness: 0.4,
            color: AppColors.lightBorderColor,
          ),
          ItemCard(
            backgroundColor: AppColors.warningColor,
            icon: Icons.delete,
            iconColor: AppColors.white,
            onTap: () {
              DialogHelper.showConfirmDialog(t.warning, t.areYouSureToDeleteAcc,
                  () {
                controller.deleteUser();
              }, context);
            },
            title: t.deleteAccount,
          ),
          Divider(
            thickness: 0.4,
            color: AppColors.lightBorderColor,
          ),
          ItemCard(
            backgroundColor: AppColors.warningColor,
            icon: Icons.logout_outlined,
            iconColor: AppColors.white,
            onTap: () {
              DialogHelper.showConfirmDialog(t.warning, t.areYouSureToLogout,
                  () {
                controller.logout();
              }, context);
            },
            title: t.logout,
          ),
          const SizedBox(
            height: 2,
          ),
        ],
      ),
    );
  }
}
