import 'package:flutter/material.dart';

class BottomSheetHelper {
  static void showBottomSheet(
      {required BuildContext context,
      double? height,
      double? width,
      Function? function,
      required Widget child}) {
    showModalBottomSheet(
        useRootNavigator: true,
        isScrollControlled: true,
        builder: (context) {
          final size = MediaQuery.of(context).size;
          return Container(
            padding: const EdgeInsets.all(8),
            height: height ?? size.height * 0.3,
            width: width ?? size.width,
            child: child,
          );
        },
        context: context);
  }
}
