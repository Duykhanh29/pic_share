import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_images.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/helper/divider_helper.dart';
import 'package:pic_share/app/helper/image_cache_helper.dart';
import 'package:pic_share/view_model/drawer/drawer_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppDrawer extends GetView<AppDrawerController> {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      surfaceTintColor: Colors.white,
      child: Column(
        children: [
          DrawerHeader(
            margin: EdgeInsets.zero,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  controller.currentUser?.urlAvatar != null
                      ? ImageCacheHelper.avatarImage(
                          url: controller.currentUser!.urlAvatar!,
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.width * 0.15)
                      : CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.075,
                          backgroundImage:
                              const AssetImage(AppImage.userEmptyAvatar),
                        ),
                  Text(
                    controller.currentUser?.name ?? "No name",
                    style: AppTextStyles.headingTextStyle(),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: ListTile(
              onTap: () {},
              title: Text(
                t.all,
                style: AppTextStyles.commonTextStyle(),
              ),
              leading: const Icon(Icons.people_alt_sharp),
            ),
          ),
          Expanded(
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: ListTile(
                      onTap: () {},
                      title: Text("Friend $index"),
                      leading: Text("data"),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    DividerHelper.sizedboxDivider(),
                itemCount: 10),
          ),
          const Divider(),
          GestureDetector(
            onTap: controller.logout,
            child: Container(
              decoration:
                  BoxDecoration(color: Colors.transparent.withOpacity(0)),
              child: ListTile(
                title: Text(
                  t.logout,
                  style: AppTextStyles.logOutTextStyle(),
                ),
                leading: const Icon(
                  Icons.logout_sharp,
                  color: AppColors.warningColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
