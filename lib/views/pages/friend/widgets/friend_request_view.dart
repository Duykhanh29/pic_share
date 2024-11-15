import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_images.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/helper/shimmer_helper.dart';
import 'package:pic_share/view_model/friend/friend_controller.dart';
import 'package:pic_share/views/pages/friend/widgets/custom_header_delegate.dart';
import 'package:pic_share/views/pages/friend/widgets/friend_card.dart';
import 'package:pic_share/views/pages/friend/widgets/suggested_friend_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/views/widgets/asset_image_widget.dart';

class FriendRequestView extends GetView<FriendController> {
  const FriendRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size.height * 0.04;
    return CustomScrollView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverPersistentHeader(
          delegate: MyCustomHeaderDelegate(
            minHeight: 40,
            maxHeight: 50,
            child: TabBar(
              onTap: (value) {
                if (value == 2) {
                  controller.fetchSuggestedFriends();
                }
              },
              tabs: [
                Tab(
                  text: t.received,
                ),
                Tab(
                  text: t.sent,
                ),
                Tab(
                  text: t.suggestions,
                ),
              ],
              labelStyle: AppTextStyles.tabBarTextStyle(),
              dividerColor: AppColors.lightTabBarColor,
              controller: controller.tabController,
              indicatorColor: AppColors.lightTabBarColor,
              mouseCursor: MouseCursor.defer,
              splashBorderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        SliverFillRemaining(
          child: Obx(
            () => controller.isLoadingFriendRequests.value
                ? ShimmerHelper().buildListViewShimmer()
                : TabBarView(
                    controller: controller.tabController,
                    children: [
                      _buildReceivedFriendRequestsView(t, size),
                      _buildSentFriendRequestsView(t, size),
                      _buildSuggestListView(t, size),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildReceivedFriendRequestsView(AppLocalizations t, double size) {
    return controller.requestedFriends.isNotEmpty
        ? ListView.builder(
            itemBuilder: (context, index) {
              final friend = controller.requestedFriends[index];
              return FriendCard(
                friend: friend,
                onItemClick: controller.onItemClick,
                isSent: false,
                onRejectClick: controller.onRejectFriendRequest,
                onAcceptClick: controller.onAcceptFriendRequest,
                key: UniqueKey(),
                isMe: controller.currentUser?.id == friend.userId,
              );
            },
            itemCount: controller.requestedFriends.length,
          )
        : _buildNoFriendRequestsView(t, size);
  }

  Widget _buildSentFriendRequestsView(AppLocalizations t, double size) {
    return controller.sentFriends.isNotEmpty
        ? ListView.builder(
            itemBuilder: (context, index) {
              final friend = controller.sentFriends[index];
              return FriendCard(
                friend: friend,
                onItemClick: controller.onItemClick,
                isSent: true,
                onRejectClick: controller.onRejectFriendRequest,
                onAcceptClick: controller.onAcceptFriendRequest,
                key: UniqueKey(),
                isMe: controller.currentUser?.id == friend.userId,
              );
            },
            itemCount: controller.sentFriends.length,
          )
        : _buildNoFriendRequestsView(t, size);
  }

  Widget _buildNoFriendRequestsView(AppLocalizations t, double size,
      {bool isSuggestion = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const AssetImageWidget(asset: AppImage.friendRequest),
        SizedBox(
          height: size,
        ),
        Text(
          isSuggestion ? t.noFriendSuggestion : t.noFriendRequests,
          style: AppTextStyles.commonTextStyle()
              .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildSuggestListView(AppLocalizations t, double size) {
    return controller.isLoadingSuggestedFriends.value
        ? ShimmerHelper().buildListViewShimmer()
        : controller.suggestedFriends.isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, index) {
                  final friend = controller.suggestedFriends[index];
                  return SuggestedFriendCard(
                    user: friend.user,
                    onTap: controller.onUserClick,
                    onMakeFriend: controller.makeFriendRequestFromSuggestion,
                    key: UniqueKey(),
                  );
                },
                itemCount: controller.suggestedFriends.length,
              )
            : _buildNoFriendRequestsView(t, size);
  }
}
