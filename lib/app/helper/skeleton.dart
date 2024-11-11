import 'package:flutter/material.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({super.key, this.height, this.width, this.radius});

  final double? height, width;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.backgroundColor,
      highlightColor: AppColors.greyBorder,
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.08),
          borderRadius: BorderRadius.all(
            Radius.circular(radius ?? 6),
          ),
        ),
      ),
    );
  }
}
