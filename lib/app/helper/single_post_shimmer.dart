import 'package:flutter/material.dart';
import 'package:pic_share/app/constants/global_data.dart';
import 'package:pic_share/app/helper/skeleton.dart';

class SinglePostShimmer extends StatelessWidget {
  const SinglePostShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTopInfo(context),
            _imageShimmer(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTopInfo(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Skeleton(width: size * 0.1, height: size * 0.1, radius: 100),
          SizedBox(width: size * 0.04),
          Skeleton(width: size * 0.2, height: size * 0.08),
          SizedBox(width: size * 0.04),
          Skeleton(width: size * 0.2, height: size * 0.08),
        ],
      ),
    );
  }

  Widget _imageShimmer(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        Skeleton(width: size.width, height: size.height * singlePostSize),
        Align(
          alignment: Alignment.centerRight,
          child: _buildActionsWidget(context),
        ),
        _buildCaption(context),
      ],
    );
  }

  Widget _buildActionsWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildButton(context),
          const SizedBox(height: 8),
          _buildButton(context),
          const SizedBox(height: 8),
          _buildButton(context),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.05),
        shape: BoxShape.circle,
      ),
      child: Skeleton(
        width: size.width * 0.08,
        height: size.width * 0.08,
        radius: 80,
      ),
    );
  }

  Widget _buildCaption(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 20,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.black.withOpacity(0.05),
          ),
          padding: const EdgeInsets.all(10),
          child: Center(
            child: SizedBox(
              width: size.width * 0.2,
              height: size.height * 0.02,
            ),
          ),
        ),
      ),
    );
  }
}
