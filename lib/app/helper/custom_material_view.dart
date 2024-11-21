import 'package:flutter/material.dart';
import 'package:pic_share/app/constants/app_color.dart';

class CustomMaterialView extends StatelessWidget {
  const CustomMaterialView({
    required this.child,
    super.key,
    this.borderRadius,
    this.color,
    this.elevation,
    this.shape,
  });
  final double? elevation;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final ShapeBorder? shape;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    return Material(
      borderRadius: borderRadius ?? BorderRadius.circular(size * 0.02),
      elevation: elevation ?? 1.0,
      shape: shape,
      color: color ?? Colors.white,
      child: Container(
        padding: EdgeInsets.all(size * 0.04),
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(size * 0.02),
          color: AppColors.white,
        ),
        child: child,
      ),
    );
  }
}
