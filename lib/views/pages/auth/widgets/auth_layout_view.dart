import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pic_share/app/constants/app_color.dart';
import 'package:pic_share/views/pages/logo_widget.dart';
import 'package:pic_share/views/widgets/keyboard_dismiss.dart';
import 'package:pic_share/views/widgets/loading_widget.dart';

class AuthLayoutView extends StatelessWidget {
  const AuthLayoutView({
    super.key,
    required this.child,
    required this.isLoading,
  });
  final bool isLoading;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Stack(
      children: [
        mainView(context),
        if (isLoading) const LoadingWidget(),
      ],
    );
  }

  Widget mainView(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    return KeyboardDismiss(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: size,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.backgroundColor,
                  AppColors.backgroundAuthScreenColor,
                  AppColors.thirdColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  height: size * 0.32,
                  alignment: Alignment.bottomCenter,
                  // padding: EdgeInsets.symmetric(vertical: size * 0.05),
                  child: const LogoWidget(),
                ),
                Positioned(
                  top: size * 0.32,
                  right: size * 0.035,
                  left: size * 0.035,
                  child: child,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
