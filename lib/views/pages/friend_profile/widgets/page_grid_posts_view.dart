import 'package:flutter/material.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/helper/image_cache_helper.dart';
import 'package:pic_share/app/helper/shimmer_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/data/models/post/post_detail.dart';

class PageGridPostsView extends StatelessWidget {
  const PageGridPostsView(
      {super.key,
      required this.onTap,
      required this.isLoading,
      required this.posts});
  final List<PostDetail> posts;
  final Function(int) onTap;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: isLoading
          ? ShimmerHelper().buildGridShimmer()
          : posts.isEmpty
              ? _buildNoPost(context)
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return GestureDetector(
                      onTap: () {
                        onTap.call(index);
                      },
                      child: ImageCacheHelper.showImage(
                          url: post.urlImage ?? "",
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width * 0.3),
                    );
                  },
                  itemCount: posts.length,
                ),
    );
  }

  Widget _buildNoPost(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Center(
        child: Text(
          t.noPosts,
          style: AppTextStyles.commonTextStyle(),
        ),
      ),
    );
  }
}
