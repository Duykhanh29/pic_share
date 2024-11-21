import 'package:flutter/material.dart';
import 'package:pic_share/app/constants/app_color.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
    required this.text,
    super.key,
    this.height,
    this.width,
    this.onTap,
    this.backgroundColor,
  });
  final double? height;
  final double? width;
  final String text;
  final Function()? onTap;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    final spaceM = MediaQuery.of(context).size.height * 0.02;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(vertical: spaceM, horizontal: spaceM * 2),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.darkSecondaryColor,
          borderRadius: BorderRadius.circular(spaceM * 2),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
