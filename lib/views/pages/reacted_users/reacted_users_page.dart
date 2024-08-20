import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/app/custom/app_bar_custom.dart';
import 'package:pic_share/app/helper/divider_helper.dart';
import 'package:pic_share/app/helper/image_cache_helper.dart';

class ReactedUsersPage extends StatelessWidget {
  const ReactedUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(title: t.reactedUser).show(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: ListTile(
                  leading: ImageCacheHelper.avatarImage(
                      url:
                          "https://i.pinimg.com/474x/68/f0/93/68f093dd88a7753a738075954abfb101.jpg"),
                  title: Text("User Name $index"),
                ),
              );
            },
            separatorBuilder: (context, index) =>
                DividerHelper.sizedboxDivider(),
            itemCount: 30),
      ),
    );
  }
}
