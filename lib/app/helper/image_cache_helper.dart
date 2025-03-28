import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/config/app_config.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/global_data.dart';
import 'package:pic_share/view_model/app/session_controller.dart';

class ImageCacheHelper {
  static Widget avatarImage(
      {required String url, double height = 30, double width = 30}) {
    return GetBuilder<SessionController>(
      builder: (controller) {
        String? token = controller.token.value;
        return CachedNetworkImage(
          imageUrl: AppConfig.baseUrl + url,
          height: height,
          width: width,
          imageBuilder: (context, imageProvider) {
            return CircleAvatar(
                radius: width / 2, backgroundImage: imageProvider);
          },
          errorWidget: (context, url, error) {
            return CircleAvatar(
                radius: width / 2, child: const Icon(Icons.error));
          },
          placeholder: (context, url) {
            return const CircleAvatar(radius: 15, child: SizedBox());
          },
          fit: BoxFit.contain,
          httpHeaders: {
            "Connection": "keep-alive",
            "Keep-Alive": "timeout=20, max=200",
            if (token != null) "Authorization": "Bearer $token"
          },
        );
      },
    );
  }

  static Widget showImage(
      {required String url, required double height, required double width}) {
    return GetBuilder<SessionController>(
      builder: (controller) {
        final token = controller.token.value;
        return CachedNetworkImage(
          imageUrl: AppConfig.baseUrl + url,
          fit: BoxFit.contain,
          height: height,
          width: width,
          imageBuilder: (context, imageProvider) {
            final isPortrait =
                MediaQuery.of(context).orientation == Orientation.portrait;
            final heightSize = MediaQuery.of(context).size.height;
            final size = isPortrait ? heightSize : heightSize * 0.45;
            final postRadius = size * radioNewPostView;
            return Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                border:
                    Border.all(color: AppColors.backgroundColor, width: 0.4),
                borderRadius: BorderRadius.circular(postRadius),
                image:
                    DecorationImage(image: imageProvider, fit: BoxFit.contain),
              ),
            );
          },
          errorWidget: (context, url, error) {
            debugPrint(
                "SOMETHING WENT WRONG TO FETCH IMAGE: ${error.toString()}");
            return const SizedBox(child: Center(child: Icon(Icons.error)));
          },
          placeholder: (context, url) {
            return SizedBox(
              width: width,
              height: height,
            );
          },
          httpHeaders: {
            "Connection": "keep-alive",
            "Keep-Alive": "timeout=20, max=200",
            if (token != null) "Authorization": "Bearer $token"
          },
        );
      },
    );
  }
}
