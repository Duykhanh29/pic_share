import 'package:flutter/material.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/app/constants/app_images.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.white, width: 2),
      ),
      margin: const EdgeInsets.symmetric(vertical: 50),
      alignment: Alignment.topCenter,
      child: Image.asset(
        AppImage.picShareLogo,
        width: 90,
        height: 90,
      ),
    );
  }
}
