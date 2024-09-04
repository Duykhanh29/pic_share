import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_images.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/custom/custom_back_button.dart';
import 'package:pic_share/app/helper/image_cache_helper.dart';
import 'package:pic_share/view_model/profile/profile_controller.dart';
import 'package:pic_share/views/pages/profile/widgets/user_code_section.dart';
import 'package:pic_share/views/pages/profile/widgets/user_detail_section.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        actions: [
          IconButton(
            onPressed: controller.onNavToEditProfile,
            icon: const Icon(
              Icons.edit,
              color: Colors.black,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(200),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                controller.currentUser?.urlAvatar != null
                    ? ImageCacheHelper.avatarImage(
                        url: controller.currentUser!.urlAvatar!,
                        height: 100,
                        width: 100)
                    : const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(AppImage.userEmptyAvatar),
                      ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  controller.currentUser?.name ?? "",
                  style: AppTextStyles.headingTextStyle(),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          "45",
                          style: AppTextStyles.headingTextStyle(),
                        ),
                        Text(
                          t.posts,
                          style: AppTextStyles.smallTextStyle(),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: VerticalDivider(
                        width: 1,
                        thickness: 0.5,
                        color: AppColors.darkBorderColor,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          "40",
                          style: AppTextStyles.headingTextStyle(),
                        ),
                        Text(
                          t.views,
                          style: AppTextStyles.smallTextStyle(),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: VerticalDivider(
                        width: 1,
                        thickness: 0.5,
                        color: AppColors.darkBorderColor,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          "34545",
                          style: AppTextStyles.headingTextStyle(),
                        ),
                        Text(
                          t.likes,
                          style: AppTextStyles.smallTextStyle(),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: CustomScrollView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: UserCodeSection(
                onCopyUserCode: controller.onCopyUserCode,
                userCode: controller.currentUser?.userCode ?? "",
              ),
            ),
            SliverToBoxAdapter(
              child: UserDetailsSection(
                email: controller.currentUser?.email ?? "",
                name: controller.currentUser?.name ?? "",
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${t.currentPosts} (18)",
                      style: AppTextStyles.commonTextStyle()
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        t.seeMore,
                        style: AppTextStyles.seeMoreTextStyle(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {},
                child: ImageCacheHelper.showImage(
                    url:
                        "https://mrwallpaper.com/images/hd/beautiful-pink-tree-3vau5vtfa3qn7k8v.jpg",
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.3),
              ),
              itemCount: 18,
            ),
          ],
        ),
      ),
    );
  }
}
