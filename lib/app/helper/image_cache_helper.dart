import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pic_share/app/config/app_config.dart';
import 'package:pic_share/app/constants/app_color.dart';

class ImageCacheHelper {
  static Widget avatarImage(
      {required String url, double height = 30, double width = 30}) {
    return CachedNetworkImage(
      imageUrl: AppConfig.baseUrl + url,
      height: height,
      width: width,
      imageBuilder: (context, imageProvider) {
        return CircleAvatar(radius: width / 2, backgroundImage: imageProvider);
      },
      errorWidget: (context, url, error) {
        return CircleAvatar(radius: width / 2, child: const Icon(Icons.error));
      },
      placeholder: (context, url) {
        return const CircleAvatar(radius: 15, child: SizedBox());
      },
      fit: BoxFit.contain,
    );
  }

  static Widget showImage(
      {required String url, required double height, required double width}) {
    return CachedNetworkImage(
      imageUrl: AppConfig.baseUrl + url,
      fit: BoxFit.contain,
      height: height,
      width: width,
      imageBuilder: (context, imageProvider) {
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.backgroundColor, width: 0.4),
            // borderRadius: BorderRadius.circular(80),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return const SizedBox(child: Center(child: Icon(Icons.error)));
      },
      placeholder: (context, url) {
        return SizedBox(
          width: width,
          height: height,
        );
      },
    );
  }
}
