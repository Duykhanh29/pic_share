import 'package:flutter/material.dart';

class AssetImageWidget extends StatelessWidget {
  const AssetImageWidget({
    super.key,
    required this.asset,
    this.height,
    this.width,
  });
  final String asset;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height * 0.08;
    return Image.asset(
      asset,
      width: width ?? size,
      height: height ?? size,
    );
  }
}
