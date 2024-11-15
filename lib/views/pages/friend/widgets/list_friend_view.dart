import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_images.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/helper/shimmer_helper.dart';
import 'package:pic_share/view_model/friend/friend_controller.dart';
import 'package:pic_share/views/pages/friend/widgets/friend_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/views/widgets/asset_image_widget.dart';

class ListFriendView extends GetView<FriendController> {
  const ListFriendView({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
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
          _buildList(context),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return Expanded(
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
                    ? _buildListFriend()
                    : _buildNoFriend(context),
          ),
        ],
      ),
    );
  }

  Widget _buildListFriend() {
    return SliverList.builder(
      itemBuilder: (context, index) {
        final friend = controller.friendList[index];
        return FriendCard(
          friend: friend,
          onItemClick: controller.onItemClick,
          onChatClick: controller.onNavToChat,
          key: UniqueKey(),
          onRejectClick: controller.onRejectFriendRequest,
          isMe: controller.currentUser?.id == friend.userId,
        );
      },
      itemCount: controller.friendList.length,
    );
  }

  Widget _buildNoFriend(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size.height;
    return SliverToBoxAdapter(
      child: SizedBox(
        height: size * 0.6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AssetImageWidget(asset: AppImage.friends),
            SizedBox(
              height: size * 0.04,
            ),
            Text(
              t.noFriends,
              style: AppTextStyles.commonTextStyle()
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
