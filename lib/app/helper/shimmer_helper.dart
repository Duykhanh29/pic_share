import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHelper {
  Widget buildBasicShimmer(
      {double height = double.infinity,
      double width = double.infinity,
      double radius = 6}) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 243, 254, 255),
      highlightColor: const Color.fromARGB(255, 212, 247, 243),
      child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: const Color.fromARGB(255, 221, 201, 224))),
    );
  }

  buildListViewShimmer() {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: const Color.fromARGB(255, 243, 254, 255),
          highlightColor: const Color.fromARGB(255, 197, 217, 215),
          child: Container(
              height: MediaQuery.of(context).size.width * 0.08,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color.fromARGB(255, 221, 201, 224))),
        );
      },
      itemCount: 10,
    );
  }

  buildGridShimmer() {
    return GridView.builder(
      itemCount: 15,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: const Color.fromARGB(255, 243, 254, 255),
          highlightColor: const Color.fromARGB(255, 197, 217, 215),
          child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color.fromARGB(255, 212, 244, 243))),
        );
      },
    );
  }

  Widget buildBasicShimmerCustomRadius(
      {double height = double.infinity,
      double? width = double.infinity,
      BorderRadius radius = BorderRadius.zero,
      Color color = Colors.grey}) {
    return Shimmer.fromColors(
      baseColor: color,
      highlightColor: Colors.amberAccent,
      child: Container(
        height: height,
        width: width,
        decoration:
            BoxDecoration(borderRadius: radius, color: Colors.purple[100]),
      ),
    );
  }

  Widget buildBasicShimmerForHorizontalList(
      {double height = double.infinity,
      double? width = double.infinity,
      BorderRadius radius = BorderRadius.zero,
      Color color = const Color.fromARGB(255, 215, 211, 211)}) {
    return Shimmer.fromColors(
      baseColor: color,
      highlightColor: const Color.fromARGB(255, 247, 242, 226),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: radius,
            color: const Color.fromARGB(255, 221, 201, 224)),
      ),
    );
  }
}
