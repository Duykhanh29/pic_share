import 'package:flutter/material.dart';
import 'package:pic_share/app/constants/app_color.dart';

class MyCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;
  final Color? backgroundColor;

  MyCustomHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
    this.backgroundColor,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.secondaryColor,
        ),
        child: child,
      ),
    );
  }

  @override
  bool shouldRebuild(MyCustomHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
