import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pinput/pinput.dart';

class LabelledOtpField extends StatelessWidget {
  const LabelledOtpField({
    required this.title,
    required this.otpController,
    super.key,
    this.onCompleted,
    this.onSubmitted,
    this.focusNode,
    this.validator,
  });

  final String title;
  final TextEditingController otpController;
  final void Function(String)? onCompleted;
  final void Function(String)? onSubmitted;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    final boxSize = size * 0.08;
    final defaultPinTheme = PinTheme(
      width: boxSize,
      height: boxSize,
      // textStyle: context.textTheme.bodyMedium?.copyWith(color: AppColors.black),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.darkBorderColor),
      ),
    );

    return Column(
      children: [
        Text(
          title,
        ),
        SizedBox(height: boxSize / 4),
        Pinput(
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
          length: 6,
          onCompleted: onCompleted,
          controller: otpController,
          onSubmitted: onSubmitted,
          separatorBuilder: (index) => const SizedBox(width: 4),
          errorPinTheme: defaultPinTheme.copyBorderWith(
            border: Border.all(color: AppColors.warningColor),
          ),
          errorTextStyle: context.textTheme.labelSmall
              ?.copyWith(color: AppColors.warningColor),
          validator: validator,
          focusNode: focusNode,
          focusedPinTheme: defaultPinTheme,
          defaultPinTheme: defaultPinTheme,
        ),
      ],
    );
  }
}
