import 'package:flutter/material.dart';
import 'package:pic_share/app/constants/app_color.dart';

class AppTextStyles {
  static TextStyle appBarTexStyle() {
    return const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  }

  static TextStyle secondAppBarTextStyle() {
    return const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
  }

  static TextStyle actionAppBarTextStyle() {
    return const TextStyle(fontSize: 15, fontWeight: FontWeight.w500);
  }

  static TextStyle tabBarTextStyle() {
    return const TextStyle(
        fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black);
  }

  static TextStyle headingTextStyle() {
    return const TextStyle(
        fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black);
  }

  static TextStyle commonTextStyle() {
    return const TextStyle(
        fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black);
  }

  static TextStyle smallTextStyle() {
    return const TextStyle(
        fontSize: 13, fontWeight: FontWeight.normal, color: Colors.black);
  }

  static TextStyle logOutTextStyle() {
    return const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.warningColor);
  }

  static TextStyle warningTextStyle() {
    return const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.warningColor);
  }

  // color of text is white
  static TextStyle appBarLightTexStyle() {
    return const TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
  }

  static TextStyle headingLightTextStyle() {
    return const TextStyle(
        fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white);
  }

  static TextStyle commonLightTextStyle() {
    return const TextStyle(
        fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white);
  }

  static TextStyle smallLightTextStyle() {
    return const TextStyle(
        fontSize: 13, fontWeight: FontWeight.normal, color: Colors.white);
  }

  // selected
  static TextStyle commonSelectedTextStyle() {
    return const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.selectedColor);
  }

  static TextStyle smallSelectedTextStyle() {
    return const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.normal,
        color: AppColors.selectedColor);
  }
}
