import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/custom/app_bar_custom.dart';
import 'package:pic_share/app/helper/divider_helper.dart';
import 'package:pic_share/view_model/language/language_controller.dart';
import 'package:pic_share/views/pages/languages/widgets/language_item_card.dart';

class LanguagePage extends GetView<LanguageController> {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(title: t.language, elevation: 5).show(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return Obx(
                () => LanguageItemCard(
                  isSelected: index == controller.selectedLanguage.value,
                  language: controller.languages[index],
                  onSelected: () async {
                    await controller.onChangeLanguage(index);
                  },
                ),
              );
            },
            separatorBuilder: (context, index) =>
                DividerHelper.sizedboxDivider(),
            itemCount: controller.languages.length),
      ),
    );
  }
}
