import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_widget/home_widget.dart';
import 'package:pic_share/app/config/home_widget_config.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/constants/strings.dart';
import 'package:pic_share/app/helper/bottom_sheet_helper.dart';
import 'package:pic_share/app/helper/image_cache_helper.dart';
import 'package:pic_share/routes/app_pages.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SinglePostContainer extends StatelessWidget {
  const SinglePostContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ImageCacheHelper.avatarImage(
                    url:
                        "https://w7.pngwing.com/pngs/340/946/png-transparent-avatar-user-computer-icons-software-developer-avatar-child-face-heroes-thumbnail.png"),
                const SizedBox(width: 28),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 223, 219, 219),
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      "name",
                      style: AppTextStyles.headingTextStyle(),
                    ),
                  ),
                ),
                const SizedBox(width: 28),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 223, 219, 219),
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      "time",
                      style: AppTextStyles.commonTextStyle(),
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () async {
                      await showActionSheet(context);
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    icon: const Icon(Icons.more_vert_outlined))
              ],
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              ImageCacheHelper.showImage(
                  url:
                      "https://mrwallpaper.com/images/hd/beautiful-pink-tree-3vau5vtfa3qn7k8v.jpg",
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.55),
              Align(
                alignment: Alignment.centerRight,
                child: _buildActionsWidget(),
              ),
              Positioned(
                bottom: 20,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black.withOpacity(0.6)),
                    padding: const EdgeInsets.all(10),
                    child: Center(
                        child: Text(
                      "Conetenenerernfsadf",
                      style: AppTextStyles.headingLightTextStyle(),
                    )),
                  ),
                ),
              )
            ],
          ),
          _buildUsersView(context),
        ],
      ),
    );
  }

  Widget _buildActionsWidget() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {},
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.favorite,
                size: 25,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ),
          Text(
            "4",
            style: AppTextStyles.commonTextStyle(),
          ),
          const SizedBox(
            height: 8,
          ),
          GestureDetector(
            onTap: () {},
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.chat,
                size: 25,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ),
          Text(
            "4",
            style: AppTextStyles.commonTextStyle(),
          ),
          const SizedBox(
            height: 8,
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.comments);
            },
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.email,
                size: 25,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsersView(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          ImageCacheHelper.avatarImage(
              url:
                  "https://img.freepik.com/premium-vector/avatar-icon002_750950-52.jpg"),
          const SizedBox(width: 10),
          ImageCacheHelper.avatarImage(
              url:
                  "https://w7.pngwing.com/pngs/340/946/png-transparent-avatar-user-computer-icons-software-developer-avatar-child-face-heroes-thumbnail.png"),
          const SizedBox(width: 10),
          ImageCacheHelper.avatarImage(
              url:
                  "https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg"),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              showUserViewSheet(context);
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 218, 217, 217)),
              child: Center(
                child: Text(
                  "+2",
                  style: AppTextStyles.smallLightTextStyle(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void showUserViewSheet(BuildContext context) {
    return BottomSheetHelper.showBottomSheet(
      height: MediaQuery.of(context).size.height * 0.9,
      context: context,
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {},
            leading: ImageCacheHelper.avatarImage(
                url:
                    "https://img.freepik.com/premium-vector/avatar-icon002_750950-52.jpg"),
            title: Text(
              "User1",
              style: AppTextStyles.commonTextStyle(),
            ),
          );
        },
        itemCount: 23,
      ),
    );
  }

  Future<void> showActionSheet(BuildContext context) async {
    final t = AppLocalizations.of(context)!;

    return Get.bottomSheet(
      Container(
        height: 300,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 187, 196, 201),
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        padding: const EdgeInsets.all(2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () async {},
              child: Center(
                child: Text(t.share),
              ),
            ),
            const Divider(
              height: 1,
              color: Colors.blueGrey,
            ),
            InkWell(
              onTap: () {},
              child: Center(
                child: Text(t.download),
              ),
            ),
            const Divider(
              height: 1,
              color: Colors.blueGrey,
            ),
            InkWell(
              onTap: () {},
              child: Center(
                child: Text(
                  t.delete,
                  style: const TextStyle(color: AppColors.warningColor),
                ),
              ),
            ),
            const Divider(
              height: 1,
              color: Colors.blueGrey,
            ),
            InkWell(
              onTap: () {
                Get.toNamed(Routes.comments);
              },
              child: Center(
                child: Text(
                  t.report,
                  style: const TextStyle(color: AppColors.warningColor),
                ),
              ),
            ),
            const Divider(
              height: 1,
              color: Colors.blueGrey,
            ),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Center(
                child: Text(
                  t.cancel,
                ),
              ),
            ),
          ],
        ),
      ),
      useRootNavigator: true,
    );
  }
}
