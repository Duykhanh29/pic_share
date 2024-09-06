import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/custom/app_bar_custom.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/routes/app_pages.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(title: t.security).show(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            ListTile(
              onTap: () {
                Get.toNamed(Routes.changePassword);
              },
              title: Text(t.changePass),
              trailing: IconButton(
                  onPressed: () {
                    Get.toNamed(Routes.changePassword);
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 18,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: AppColors.darkBorderColor,
                thickness: 0.3,
              ),
            ),
            ListTile(
              onTap: () {},
              title: Text(t.termConditions),
              trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 18,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
