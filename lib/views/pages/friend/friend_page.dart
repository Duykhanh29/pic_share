import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/app/custom/custom_back_button.dart';
import 'package:pic_share/app/helper/shimmer_helper.dart';
import 'package:pic_share/view_model/friend/friend_controller.dart';
import 'package:pic_share/views/pages/friend/widgets/custom_header_delegate.dart';
import 'package:pic_share/views/pages/friend/widgets/friend_card.dart';
import 'package:pic_share/views/pages/friend/widgets/suggested_friend_card.dart';
import 'package:pic_share/views/widgets/loading_widget.dart';

class FriendPage extends GetView<FriendController> {
  const FriendPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            appBar: _buildAppBar(t),
            body: RefreshIndicator(
              onRefresh: controller.onRefresh,
              child: controller.isFriendShipView.value
                  ? _buildListFriendView(t, context)
                  : _buildFriendRequestsView(t),
            ),
          ),
          if (controller.isActionLoading.value) const LoadingWidget(),
        ],
      ),
    );
  }

  AppBar _buildAppBar(AppLocalizations t) {
    return AppBar(
      backgroundColor: AppColors.secondaryColor,
      leading: Obx(() =>
          controller.isViewInTabbar.value && controller.isFriendShipView.value
              ? const SizedBox.shrink()
              : controller.isFriendShipView.value
                  ? CustomBackButton(
                      onBack: controller.onResetViewInTabBar,
                    )
                  : SizedBox(
                      height: 45,
                      width: 45,
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            controller.onChangeView();
                          },
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                    )),
      title: Obx(
        () => Text(
          controller.isFriendShipView.value ? t.friends : t.friendRequests,
          style: AppTextStyles.appBarTexStyle(),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: IconButton(
            onPressed: controller.onNavToSearch,
            icon: const Icon(Icons.search),
          ),
        ),
      ],
    );
  }

  Widget _buildListFriendView(AppLocalizations t, BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              child: GestureDetector(
                onTap: controller.onChangeView,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.lightBorderColor,
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: AppColors.blue),
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                          Icons.people_alt_rounded,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        t.friendRequests,
                        style: AppTextStyles.commonTextStyle(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: CustomScrollView(
                // shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                slivers: [
                  Obx(
                    () => controller.isLoadingFriends.value
                        ? SliverToBoxAdapter(
                            child: ShimmerHelper().buildListViewShimmer(),
                          )
                        : controller.friendList.isNotEmpty
                            ? SliverList.builder(
                                itemBuilder: (context, index) {
                                  final friend = controller.friendList[index];
                                  return FriendCard(
                                    friend: friend,
                                    onItemClick: controller.onItemClick,
                                    onChatClick: controller.onNavToChat,
                                    key: UniqueKey(),
                                    onRejectClick:
                                        controller.onRejectFriendRequest,
                                    isMe: controller.currentUser?.id ==
                                        friend.userId,
                                  );
                                },
                                itemCount: controller.friendList.length,
                              )
                            : SliverToBoxAdapter(
                                child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                child: Center(
                                  child: Text(
                                    t.noFriends,
                                    style: AppTextStyles.commonTextStyle()
                                        .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _buildFriendRequestsView(AppLocalizations t) {
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
                      _buildReceivedFriendRequestsView(t),
                      _buildSentFriendRequestsView(t),
                      _buildSuggestListView(t),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildReceivedFriendRequestsView(AppLocalizations t) {
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
        : _buildNoFriendRequestsView(t);
  }

  Widget _buildSentFriendRequestsView(AppLocalizations t) {
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
        : _buildNoFriendRequestsView(t);
  }

  Widget _buildNoFriendRequestsView(AppLocalizations t,
      {bool isSuggestion = false}) {
    return Center(
      child: Text(
        isSuggestion ? t.noFriendSuggestion : t.noFriendRequests,
        style: AppTextStyles.commonTextStyle()
            .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildSuggestListView(AppLocalizations t) {
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
            : _buildNoFriendRequestsView(t);
  }
}
