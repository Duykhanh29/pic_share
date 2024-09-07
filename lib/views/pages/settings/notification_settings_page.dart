import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/custom/app_bar_custom.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/view_model/settings/settings_controller.dart';

class NotificationSettingsPage extends GetView<SettingsController> {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(title: t.notiSettings).show(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            SwitchListTile(
              value: controller.isShowNotification.value,
              onChanged: controller.onChangeShowNotification,
              title: Text(
                t.showNotifications,
                style: AppTextStyles.commonTextStyle(),
              ),
            ),
            const SizedBox(height: 10),
            SwitchListTile(
              value: controller.isShowNotificationWithSound.value,
              onChanged: controller.onChangeShowNotificationWithSound,
              title: Text(
                t.sound,
                style: AppTextStyles.commonTextStyle(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
