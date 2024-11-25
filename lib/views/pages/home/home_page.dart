import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_images.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/custom/app_bar_custom.dart';
import 'package:pic_share/app/helper/shimmer_helper.dart';
import 'package:pic_share/view_model/home/home_controller.dart';
import 'package:pic_share/views/components/app_drawer.dart';
import 'package:pic_share/views/pages/home/widgets/single_post_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/views/widgets/asset_image_widget.dart';
import 'package:pic_share/views/widgets/keyboard_dismiss.dart';
import 'package:badges/badges.dart' as badges;
import 'package:pic_share/views/widgets/loading_widget.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return KeyboardDismiss(
      child: Scaffold(
        drawer: const AppDrawer(),
        appBar: CustomAppBar(
          title: t.home,
          isLeadingShow: false,
          actions: [
            InkWell(
              onTap: controller.onNavToNotification,
              child: badges.Badge(
                badgeContent: Obx(
                  () => Text(
                    "${controller.unseenNotiCount.value}",
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
                child: const Icon(
                  Icons.notifications,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            IconButton(
              onPressed: controller.onNavToGridPostView,
              icon: const Icon(Icons.view_comfortable_outlined),
            ),
          ],
        ).show(),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final availableHeight = getAvailableHeight(context);
    return RefreshIndicator(
      onRefresh: controller.onRefresh,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 2),
        ),
        child: Obx(
          () => controller.isActionLoading.value
              ? const LoadingWidget()
              : controller.isLoading.value
                  ? ShimmerHelper().buildListPostShimmer(context)
                  : controller.actualDisplayPosts.length < 2
                      ? (SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: controller.actualDisplayPosts.isEmpty
                              ? SizedBox(
                                  height: availableHeight,
                                  child: _buildNoPost(context),
                                )
                              : SizedBox(
                                  height: availableHeight,
                                  child: _buildListPost(context),
                                ),
                        ))
                      : _buildListPost(context),
        ),
      ),
    );
  }

  Widget _buildNoPost(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size.height;
    return SizedBox(
      height: size,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AssetImageWidget(asset: AppImage.emptyPhoto),
            SizedBox(
              height: size * 0.04,
            ),
            Text(
              t.noPhotoSharing,
              style: AppTextStyles.commonTextStyle().copyWith(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListPost(BuildContext context) {
    return Obx(
      () => CarouselSlider.builder(
        key: ValueKey(controller.currentIndex.value),
        options: CarouselOptions(
          autoPlayAnimationDuration: const Duration(seconds: 1),
          autoPlayCurve: Curves.linear,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.height,
          initialPage: controller.currentIndex.value,
          pageSnapping: true,
          autoPlay: false,
          // autoPlay: true,
          height: MediaQuery.of(context).size.height,
          viewportFraction: 1.0,
          enableInfiniteScroll: false,
          autoPlayInterval: const Duration(seconds: 4),
          scrollDirection: Axis.vertical,
          onPageChanged: (
            index,
            reason,
          ) {
            controller.currentIndex.value = index;
          },
        ),
        itemCount: controller.actualDisplayPosts.length,
        itemBuilder: (context, index, realIndex) {
          final post = controller.actualDisplayPosts[index];
          return SinglePostContainer(
            postData: post,
            isMe: controller.currentUser?.id == post.post.user?.id,
          );
        },
      ),
    );
  }

  double getAvailableHeight(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    const appBarHeight = kToolbarHeight;
    const bottomNavBarHeight = kBottomNavigationBarHeight;
    return mediaQuery.size.height - appBarHeight - bottomNavBarHeight;
  }
}
