import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_color.dart';

class BottomSheetBottom extends StatelessWidget {
  const BottomSheetBottom({
    required this.title,
    required this.onTap,
    super.key,
    this.backgroundColor,
    this.textColor,
  });

  final String title;
  final Function()? onTap;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            title,
            style: context.textTheme.bodyMedium?.copyWith(
              color: textColor ?? AppColors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
}
