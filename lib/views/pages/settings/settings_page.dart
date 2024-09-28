import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/custom/app_bar_custom.dart';
import 'package:pic_share/view_model/settings/settings_controller.dart';
import 'package:pic_share/views/pages/settings/widgets/account_settings_section.dart';
import 'package:pic_share/views/pages/settings/widgets/general_settings_section.dart';
import 'package:pic_share/views/pages/settings/widgets/user_section_widget.dart';
import 'package:pic_share/views/pages/settings/widgets/user_settings_section.dart';
import 'package:pic_share/views/widgets/loading_widget.dart';

class SettinngsPage extends GetView<SettingsController> {
  const SettinngsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            appBar:
                CustomAppBar(title: t.settings, isLeadingShow: false).show(),
            body: const Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    UserSectionWidget(),
                    UserSettingsSection(),
                    GeneralSettingsSection(),
                    AccountSettingsSection(),
                  ],
                ),
              ),
            ),
          ),
          if (controller.isLoading.value) const LoadingWidget(),
        ],
      ),
    );
  }
}
