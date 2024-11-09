import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/helper/divider_helper.dart';
import 'package:pic_share/view_model/drawer/drawer_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/views/widgets/avatar_widget.dart';

class AppDrawer extends GetView<AppDrawerController> {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    final sizeWidth = size.width;
    return Drawer(
      width: sizeWidth * 0.7,
      surfaceTintColor: Colors.white,
      child: Column(
        children: [
          DrawerHeader(
            margin: EdgeInsets.zero,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: AvatarWidget(
                      urlAvatar: controller.currentUser?.urlAvatar,
                      width: sizeWidth * 0.15,
                      height: sizeWidth * 0.15,
                      radius: sizeWidth * 0.075,
                    ),
                  ),
                  Center(
                    child: Text(
                      controller.currentUser?.name ?? t.noName,
                      style: AppTextStyles.headingTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Obx(
              () => ListTile(
                selectedColor: controller.selectedUserId.value == null
                    ? AppColors.selectedColor
                    : null,
                selected: controller.selectedUserId.value == null,
                onTap: () {
                  controller.onChangeSelectedUserId(null);
                  controller.closeDrawer(context);
                },
                title: Text(
                  t.all,
                  style: AppTextStyles.commonTextStyle(),
                ),
                leading: const Icon(Icons.people_alt_sharp),
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final friend = controller.friendList[index];
                    return Obx(
                      () => Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: ListTile(
                          onTap: () {
                            controller.onChangeSelectedUserId(
                              friend.userId != controller.currentUser?.id
                                  ? friend.userId
                                  : friend.friendId,
                            );
                            controller.closeDrawer(context);
                          },
                          title: Text(
                            friend.name ?? "",
                            style: AppTextStyles.commonTextStyle().copyWith(
                              color:
                                  (friend.userId != controller.currentUser?.id
                                          ? controller.selectedUserId.value ==
                                              friend.userId
                                          : controller.selectedUserId.value ==
                                              friend.friendId)
                                      ? AppColors.selectedColor
                                      : null,
                            ),
                          ),
                          leading: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color:
                                    (friend.userId != controller.currentUser?.id
                                            ? controller.selectedUserId.value ==
                                                friend.userId
                                            : controller.selectedUserId.value ==
                                                friend.friendId)
                                        ? AppColors.selectedColor
                                        : null,
                                shape: BoxShape.circle,
                              ),
                              child: AvatarWidget(
                                urlAvatar: friend.avatar,
                                height: sizeWidth * 0.075,
                                width: sizeWidth * 0.075,
                                radius: sizeWidth * 0.075 / 2,
                              )),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      DividerHelper.sizedBoxDivider(),
                  itemCount: controller.friendList.length),
            ),
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
