import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_images.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/custom/app_bar_custom.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/app/helper/image_cache_helper.dart';
import 'package:pic_share/view_model/deleted_post/deleted_post_controller.dart';
import 'package:pic_share/app/utils/date_utils.dart' as helper;

class DeletedPostPage extends GetView<DeletedPostController> {
  const DeletedPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: CustomAppBar(title: t.deletedPost).show(),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTopInfo(context, t),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ImageCacheHelper.showImage(
                        url: controller.deletedPost.value?.image ??
                            "https://picsum.photos/seed/picsum/200/300",
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.55),
                    Align(
                      alignment: Alignment.centerRight,
                      child: _buildActionsWidget(),
                    ),
                    _buildCaption(),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildTopInfo(BuildContext context, AppLocalizations t) {
    final post = controller.deletedPost.value;
    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          controller.currentUser?.urlAvatar != null
              ? ImageCacheHelper.avatarImage(
                  url: controller.currentUser!.urlAvatar!)
              : const CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage(
                    AppImage.userEmptyAvatar,
                  ),
                ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 223, 219, 219),
                borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: Text(
                t.you,
                style: AppTextStyles.headingTextStyle(),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.25),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 223, 219, 219),
                borderRadius: BorderRadius.circular(5)),
            alignment: Alignment.center,
            child: Text(
              post?.createdAt != null
                  ? helper.DateUtils.formatDateTimeToString(post!.createdAt!)
                  : "",
              maxLines: 3,
              textAlign: TextAlign.center,
              style: AppTextStyles.smallTextStyle(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionsWidget() {
    final post = controller.deletedPost.value;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildButton(Icons.favorite, iconColor: Colors.red.withOpacity(0.9)),
          Text(
            post?.likeCount.toString() ?? "",
            style: AppTextStyles.commonTextStyle(),
          ),
          const SizedBox(
            height: 8,
          ),
          _buildButton(
            Icons.comment,
          ),
          Text(
            post?.cmtCount.toString() ?? "",
            style: AppTextStyles.commonTextStyle(),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(IconData icon, {Color? iconColor}) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        icon,
        size: 25,
        color: iconColor ?? Colors.white.withOpacity(0.9),
      ),
    );
  }

  Widget _buildCaption() {
    final post = controller.deletedPost.value;
    return post?.caption != null
        ? Positioned(
            bottom: 20,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black.withOpacity(0.6)),
                padding: const EdgeInsets.all(10),
                child: Center(
                    child: Text(
                  post!.caption ?? "",
                  style: AppTextStyles.headingLightTextStyle(),
                )),
              ),
            ),
          )
        : const Positioned(
            bottom: 20,
            child: SizedBox.shrink(),
          );
  }
}
