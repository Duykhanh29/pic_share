import 'package:flutter/material.dart';
import 'package:pic_share/app/constants/app_text_styles.dart';
import 'package:pic_share/app/custom/custom_back_button.dart';
import 'package:pic_share/app/constants/app_color.dart';

class CustomAppBar {
  final bool? centerTitle;
  final String title;
  final List<Widget> actions;
  final void Function()? onBack;
  final Color? background;
  final double? elevation;
  final bool isLeadingShow;
  final TextStyle? textStyle;
  const CustomAppBar(
      {required this.title,
      this.actions = const [],
      this.onBack,
      this.background,
      this.elevation,
      this.centerTitle = false,
      this.isLeadingShow = true,
      this.textStyle});
  AppBar show() {
    return AppBar(
      centerTitle: centerTitle,
      backgroundColor: background ?? AppColors.secondaryColor,
      elevation: elevation,
      actions: actions,
      leading: isLeadingShow ? CustomBackButton(onBack: onBack) : null,
      title: Text(
        title,
        style: textStyle ?? AppTextStyles.appBarTexStyle(),
      ),
    );
  }
}
