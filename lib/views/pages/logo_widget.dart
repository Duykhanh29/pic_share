import 'package:flutter/material.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_images.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    final radiusSize = size * 0.13;
    final logoSize = size * 0.12;
    return Container(
      height: radiusSize,
      width: radiusSize,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.white, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: AppColors.backgroundAuthScreenColor,
              blurRadius: 0,
              spreadRadius: 2,
              offset: const Offset(0, 1),
            )
          ]),
      margin: EdgeInsets.symmetric(vertical: size * 0.05),
      alignment: Alignment.center,
      child: Image.asset(
        AppImage.picShareLogo,
        width: logoSize,
        height: logoSize,
      ),
    );
  }
}
