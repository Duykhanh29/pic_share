import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/app/custom/custom_back_button.dart';
import 'package:pic_share/view_model/friend/friend_controller.dart';
import 'package:pic_share/views/pages/friend/widgets/custom_header_delegate.dart';
import 'package:pic_share/views/pages/friend/widgets/friend_card.dart';

class FriendPage extends GetView<FriendController> {
  const FriendPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        leading: Obx(() => controller.isFriendShipView.value
            ? const CustomBackButton()
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
      ),
      body: Obx(
        () => controller.isFriendShipView.value
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                                    shape: BoxShape.circle,
                                    color: AppColors.blue),
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
                        SliverList.builder(
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
                        ),
                      ],
                    ),
                  ],
                ))
            : CustomScrollView(
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
                    child: TabBarView(
                      controller: controller.tabController,
                      children: [
                        ListView.builder(
                          itemBuilder: (context, index) {
                            final friend = controller.requestedFriends[index];
                            return FriendCard(
                              friend: friend,
                              onItemClick: controller.onItemClick,
                              isSent: false,
                              onRejectClick: controller.onRejectFriendRequest,
                              onAccepttClick: controller.onAcceptFriendRequest,
                              key: UniqueKey(),
                            );
                          },
                          itemCount: controller.requestedFriends.length,
                        ),
                        ListView.builder(
                          itemBuilder: (context, index) {
                            final friend = controller.sentFriends[index];
                            return FriendCard(
                              friend: friend,
                              onItemClick: controller.onItemClick,
                              isSent: true,
                              onRejectClick: controller.onRejectFriendRequest,
                              onAccepttClick: controller.onAcceptFriendRequest,
                              key: UniqueKey(),
                            );
                          },
                          itemCount: controller.sentFriends.length,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
