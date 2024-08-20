import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/app/custom/app_bar_custom.dart';
import 'package:pic_share/app/helper/divider_helper.dart';
import 'package:pic_share/views/pages/languages/widgets/language_item_card.dart';

class LanguagePage extends StatelessWidget {
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
              return LanguageItemCard(
                isSelected: index % 2 == 0,
              );
            },
            separatorBuilder: (context, index) =>
                DividerHelper.sizedboxDivider(),
            itemCount: 12),
      ),
    );
  }
}
