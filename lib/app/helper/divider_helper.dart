import 'package:flutter/material.dart';

class DividerHelper {
  DividerHelper._();
  static Widget sizedBoxDivider({double? height}) {
    return SizedBox(
      height: height ?? 5,
    );
  }

  static Widget basicDivider() {
    return const Divider(
      height: 1,
      color: Colors.blueGrey,
    );
  }

  static Widget headingDivider(String header) {
    return Container(
      // padding: const EdgeInsets.only(left: 15, bottom: 10, top: 20),
      margin: const EdgeInsets.only(left: 5, bottom: 10, top: 10),
      decoration: const BoxDecoration(color: Colors.red),
      // height: 15,
      // alignment: Alignment.centerLeft,
      child: Text(
        header,
        // style: AppTextStyles.headingTextStyle(),
      ),
    );
  }
}
