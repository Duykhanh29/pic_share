import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_images.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/custom/custom_back_button.dart';
import 'package:pic_share/app/helper/image_cache_helper.dart';
import 'package:pic_share/app/helper/shimmer_helper.dart';
import 'package:pic_share/view_model/profile/profile_controller.dart';
import 'package:pic_share/views/pages/profile/widgets/user_code_section.dart';
import 'package:pic_share/views/pages/profile/widgets/user_detail_section.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/views/pages/profile/widgets/user_log_widget.dart';
import 'package:pic_share/views/widgets/avatar_widget.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: _buildAppBar(context),
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
            _buildRowForHistory(context, t),
            _buildHistories(context, t),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width * 0.2;
    return AppBar(
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
        preferredSize: const Size.fromHeight(250),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AvatarWidget(
                urlAvatar: controller.currentUser?.urlAvatar,
                height: width,
                width: width,
                radius: width / 2,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text(
                controller.currentUser?.name ?? "",
                style: AppTextStyles.headingTextStyle(),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Obx(
                () => controller.isUserLogLoading.value
                    ? ShimmerHelper().buildBasicShimmer(
                        height: 80,
                        width: MediaQuery.of(context).size.width * 0.85)
                    : UserLogWidget(
                        likeCount: controller.userLog.value?.totalLikes ?? 0,
                        postCount: controller.userLog.value?.totalPosts ?? 0,
                        viewCount: controller.userLog.value?.totalView ?? 0,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRowForHistory(BuildContext context, AppLocalizations t) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                t.currentPosts,
                style: AppTextStyles.commonTextStyle()
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            TextButton(
              onPressed: controller.onNavToPostHistory,
              child: Text(
                t.seeMore,
                style: AppTextStyles.seeMoreTextStyle(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistories(BuildContext context, AppLocalizations t) {
    return Obx(() => controller.isLoading.value
        ? SliverToBoxAdapter(
            child: ShimmerHelper().buildGridShimmer(),
          )
        : controller.latestPosts.isEmpty
            ? SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Center(
                    child: Text(
                      t.noPosts,
                      style: AppTextStyles.commonTextStyle(),
                    ),
                  ),
                ),
              )
            : SliverToBoxAdapter(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    final post = controller.latestPosts[index];
                    return GestureDetector(
                      onTap: () {
                        controller.onTapDetail(post.id ?? 0);
                      },
                      child: post.urlImage != null
                          ? ImageCacheHelper.showImage(
                              url: post.urlImage ?? "",
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.width * 0.3)
                          : Image.asset(AppImage.placeHolder,
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.width * 0.3),
                    );
                  },
                  itemCount: controller.latestPosts.length,
                ),
              ));
  }
}
