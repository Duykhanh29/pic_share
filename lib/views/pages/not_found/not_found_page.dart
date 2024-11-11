import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pic_share/app/constants/app_resources.dart';
import 'package:pic_share/app/custom/app_bar_custom.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CustomAppBar(title: "404").show(),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Lottie.asset(AppResources.notFound, height: size.height * 0.6),
        ),
      ),
    );
  }
}
