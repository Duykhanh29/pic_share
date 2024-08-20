import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key, this.onBack});
  final void Function()? onBack;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 45,
      child: Center(
        child: InkWell(
          onTap: () {
            Get.back();
            if (onBack != null) {
              onBack!();
            }
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}
