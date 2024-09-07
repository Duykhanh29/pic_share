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

class FriendPage extends GetView<FriendController> {
  const FriendPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: _buildAppBar(t),
      body: RefreshIndicator(
        onRefresh: controller.onRefresh,
        child: Obx(
          () => controller.isFriendShipView.value
              ? _buildListFriendView(t)
              : _buildFriendRequestsView(t),
        ),
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
          controller.isFriendShipView.value ? t.friend : t.friendRequests,
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

  Widget _buildListFriendView(AppLocalizations t) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: ListView(
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
            CustomScrollView(
              shrinkWrap: true,
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
                                );
                              },
                              itemCount: controller.friendList.length,
                            )
                          : SliverToBoxAdapter(
                              child: Center(
                              child: Text(
                                t.noFriends,
                                style: AppTextStyles.commonTextStyle().copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            )),
                ),
              ],
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
              tabs: [
                Tab(
                  text: t.received,
                ),
                Tab(
                  text: t.sent,
                ),
              ],
              labelStyle: AppTextStyles.tabBarTextStyle(),
              dividerColor: AppColors.lightTabarColor,
              controller: controller.tabController,
              indicatorColor: AppColors.lightTabarColor,
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
                      controller.requestedFriends.isNotEmpty
                          ? ListView.builder(
                              itemBuilder: (context, index) {
                                final friend =
                                    controller.requestedFriends[index];
                                return FriendCard(
                                  friend: friend,
                                  onItemClick: controller.onItemClick,
                                  isSent: false,
                                  onRejectClick:
                                      controller.onRejectFriendRequest,
                                  onAccepttClick:
                                      controller.onAcceptFriendRequest,
                                  key: UniqueKey(),
                                );
                              },
                              itemCount: controller.requestedFriends.length,
                            )
                          : Center(
                              child: Text(
                                t.noFriendRequests,
                                style: AppTextStyles.commonTextStyle().copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                      controller.sentFriends.isNotEmpty
                          ? ListView.builder(
                              itemBuilder: (context, index) {
                                final friend = controller.sentFriends[index];
                                return FriendCard(
                                  friend: friend,
                                  onItemClick: controller.onItemClick,
                                  isSent: true,
                                  onRejectClick:
                                      controller.onRejectFriendRequest,
                                  onAccepttClick:
                                      controller.onAcceptFriendRequest,
                                  key: UniqueKey(),
                                );
                              },
                              itemCount: controller.sentFriends.length,
                            )
                          : Center(
                              child: Text(
                                t.noFriendRequests,
                                style: AppTextStyles.commonTextStyle().copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
