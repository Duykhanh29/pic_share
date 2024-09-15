import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/custom/app_bar_custom.dart';
import 'package:pic_share/app/helper/image_cache_helper.dart';
import 'package:pic_share/app/helper/shimmer_helper.dart';
import 'package:pic_share/data/models/post/post.dart';
import 'package:pic_share/view_model/post_history/post_history_controller.dart';

class PostHistoryPage extends GetView<PostHistoryController> {
  const PostHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: t.postHistories,
      ).show(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Obx(
          () => controller.isLoading.value
              ? ShimmerHelper().buildGridShimmer()
              : PagedGridView(
                  pagingController: controller.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Post>(
                    itemBuilder: (context, post, index) {
                      return GestureDetector(
                        onTap: () {
                          controller.onClick(index);
                        },
                        child: ImageCacheHelper.showImage(
                            url: post.urlImage ?? "",
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.3),
                      );
                    },
                    firstPageProgressIndicatorBuilder: (context) =>
                        ShimmerHelper().buildGridShimmer(),
                    noItemsFoundIndicatorBuilder: (context) => SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: Center(
                        child: Text(
                          t.noPosts,
                          style: AppTextStyles.commonTextStyle(),
                        ),
                      ),
                    ),
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  showNoMoreItemsIndicatorAsGridChild: false,
                  shrinkWrap: true,
                ),
        ),
      ),
    );
  }
}
