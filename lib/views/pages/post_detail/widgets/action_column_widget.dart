import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/constants/strings.dart';
import 'package:pic_share/data/models/post/post_data.dart';
import 'package:pic_share/routes/app_pages.dart';

class ActionColumnWidget extends StatelessWidget {
  const ActionColumnWidget({
    super.key,
    required this.addLike,
    required this.dislikePost,
    required this.postData,
    required this.onNavToLocationView,
  });
  final Function(int) addLike;
  final Function({required int id, required int userId}) dislikePost;
  final Function() onNavToLocationView;
  final PostData postData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildButton(
            icon: Icons.comment,
            onTap: () async {
              if (postData.isLike) {
                await dislikePost(
                    id: postData.post.id ?? 0,
                    userId: postData.post.userID ?? 0);
              } else {
                await addLike(postData.post.id ?? 0);
              }
            },
            iconColor: Colors.red.withOpacity(0.9),
          ),
          Text(
            postData.post.likeCount.toString(),
            style: AppTextStyles.commonTextStyle(),
          ),
          const SizedBox(
            height: 8,
          ),
          _buildButton(
              icon: Icons.comment,
              onTap: () {
                Get.toNamed(Routes.comments, arguments: {
                  Strings.postId: postData.post.id,
                });
              }),
          Text(
            postData.post.cmtCount.toString(),
            style: AppTextStyles.commonTextStyle(),
          ),
          const SizedBox(
            height: 8,
          ),
          _buildButton(
            icon: Icons.location_on,
            onTap: () {
              onNavToLocationView();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required Function() onTap,
    Color? iconColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
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
      ),
    );
  }
}
