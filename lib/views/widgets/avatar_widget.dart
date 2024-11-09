import 'package:flutter/material.dart';
import 'package:pic_share/app/constants/app_images.dart';
import 'package:pic_share/app/helper/image_cache_helper.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    super.key,
    this.onTap,
    this.urlAvatar,
    this.height,
    this.width,
    this.radius,
  });
  final Function()? onTap;
  final String? urlAvatar;
  final double? width;
  final double? height;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return _buildAvatar(context);
  }

  Widget _buildAvatar(BuildContext context) {
    return urlAvatar != null
        ? ImageCacheHelper.avatarImage(
            url: urlAvatar!,
            width: width ?? MediaQuery.of(context).size.height * 0.06,
            height: height ?? MediaQuery.of(context).size.height * 0.06,
          )
        : CircleAvatar(
            radius: radius ?? MediaQuery.of(context).size.height * 0.03,
            backgroundImage: const AssetImage(AppImage.userEmptyAvatar),
          );
  }
}
