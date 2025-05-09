import 'package:flutter/material.dart';
import 'package:pic_share/app/constants/app_images.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/custom/app_bar_custom.dart';
import 'package:pic_share/app/helper/image_cache_helper.dart';
import 'package:pic_share/app/helper/shimmer_helper.dart';
import 'package:pic_share/views/components/app_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:pic_share/view_model/home/home_controller.dart';
import 'package:pic_share/views/widgets/asset_image_widget.dart';
import 'package:pic_share/app/constants/strings.dart';

class GridPostPage extends GetView<HomeController> {
  const GridPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: CustomAppBar(title: t.home).show(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Obx(
          () => controller.isLoading.value
              ? ShimmerHelper().buildGridShimmer()
              : controller.actualDisplayPosts.isEmpty
                  ? _buildNoPost(context)
                  : GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        final id =
                            controller.actualDisplayPosts[index].post.id ??
                                hashCode;
                        return GestureDetector(
                          onTap: () {
                            controller.onNavigateToHomeWithIndex(index);
                          },
                          child: Hero(
                            tag: "${Strings.postHero}_$id",
                            child: ImageCacheHelper.showImage(
                                url: controller.actualDisplayPosts[index].post
                                        .urlImage ??
                                    "",
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                width: MediaQuery.of(context).size.width * 0.3),
                          ),
                        );
                      },
                      itemCount: controller.actualDisplayPosts.length,
                    ),
        ),
      ),
    );
  }

  Widget _buildNoPost(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size.height;
    return Center(
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
    );
  }
}
