import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/custom/custom_back_button.dart';
import 'package:pic_share/app/helper/shimmer_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/view_model/friend_profile/friend_profile_controller.dart';
import 'package:pic_share/views/pages/friend_profile/widgets/button_row_widget.dart';
import 'package:pic_share/views/pages/friend_profile/widgets/mutual_friend_list_view.dart';
import 'package:pic_share/views/pages/friend_profile/widgets/page_grid_posts_view.dart';
import 'package:pic_share/views/pages/friend_profile/widgets/user_log_vertical.dart';
import 'package:pic_share/views/widgets/avatar_widget.dart';

class FriendProfilePage extends GetView<FriendProfileController> {
  const FriendProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Stack(
      children: [
        Scaffold(
          appBar: _buildAppBar(context, t),
          body: _buildBody(context, t),
        )
      ],
    );
  }

  AppBar _buildAppBar(BuildContext context, AppLocalizations t) {
    return AppBar(
      leading: const CustomBackButton(),
      title: Text(
        t.profile,
        style: AppTextStyles.headingTextStyle(),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(240),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTopbar(context),
              _buildButtons(t),
              TabBar(
                tabs: [
                  Tab(
                    text: t.posts,
                  ),
                  Tab(
                    text: t.mutualFriends,
                  ),
                ],
                labelStyle: AppTextStyles.tabBarTextStyle(),
                controller: controller.tabController,
                indicatorColor: AppColors.lightTabBarColor,
                mouseCursor: MouseCursor.defer,
                splashBorderRadius: BorderRadius.circular(5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopbar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(flex: 4, child: _buildAvatarAndName(context)),
          Flexible(
            flex: 6,
            child: Obx(
              () => controller.isUserLogLoading.value
                  ? ShimmerHelper().buildBasicShimmer(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width * 0.5)
                  : UserLogVerticalWidget(
                      likeCount: controller.userLog.value?.totalLikes ?? 0,
                      postCount: controller.userLog.value?.totalPosts ?? 0,
                      viewCount: controller.userLog.value?.totalView ?? 0,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarAndName(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    final avatarSize = size * 0.1;
    return Column(
      children: [
        AvatarWidget(
          urlAvatar: controller.friend.value?.urlAvatar,
          height: avatarSize,
          width: avatarSize,
          radius: avatarSize / 2,
        ),
        SizedBox(
          height: size * 0.02,
        ),
        Text(
          controller.friend.value?.name ?? "",
          style: AppTextStyles.headingTextStyle(),
        ),
        SizedBox(
          height: size * 0.02,
        ),
      ],
    );
  }

  Widget _buildButtons(AppLocalizations t) {
    return Obx(() => controller.isLoading.value
        ? const SizedBox.shrink()
        : ButtonRowWidget(
            friend: controller.currentFriend.value,
            onAcceptTap: (id) async {
              await controller.onAcceptFriendRequest(id: id);
            },
            onAddFriendTap: (userId) async {
              await controller.onMakeFriendRequest(userId);
            },
            onChatClick: () => controller.onChatClick(),
            onRejectTap: (id) async {
              await controller.onRejectFriendRequest(id: id);
            },
          ));
  }

  Widget _buildBody(BuildContext context, AppLocalizations t) {
    return Obx(
      () => CustomScrollView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            child: Column(
              children: [
                Expanded(
                  child: TabBarView(
                    controller: controller.tabController,
                    children: [
                      _buildGridViewPosts(t),
                      _buildMutualFriendsView(context, t)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridViewPosts(AppLocalizations t) {
    return PageGridPostsView(
        pagingController: controller.pagingController,
        ontap: (index) {
          controller.onClick(index);
        });
  }

  Widget _buildMutualFriendsView(BuildContext context, AppLocalizations t) {
    return MuatualFriendListView(
      isLoading: controller.isMutualFriendLoading.value,
      mutualFriends: controller.mutualFriends,
      onTap: controller.onMutualFriendClick,
    );
  }
}
