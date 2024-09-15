import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/custom/app_bar_custom.dart';
import 'package:pic_share/app/helper/shimmer_helper.dart';
import 'package:pic_share/view_model/home/home_controller.dart';
import 'package:pic_share/views/components/app_drawer.dart';
import 'package:pic_share/views/pages/home/widgets/single_post_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: CustomAppBar(
        title: t.home,
        isLeadingShow: false,
        actions: [
          IconButton(
            onPressed: controller.onNavToNotification,
            icon: const Icon(Icons.notifications),
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
      body: RefreshIndicator(
        onRefresh: controller.onRefresh,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 2),
          ),
          child: Obx(
            () => controller.isLoading.value
                ? ShimmerHelper().buildCarouselSliderShimmer(context)
                : Obx(
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
                      itemCount: controller.posts.length,
                      itemBuilder: (context, index, realIndex) {
                        final post = controller.posts[index];
                        return SinglePostContainer(
                          postData: post,
                        );
                      },
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
