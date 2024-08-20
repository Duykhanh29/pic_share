import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/custom/app_bar_custom.dart';
import 'package:pic_share/routes/app_pages.dart';
import 'package:pic_share/views/components/app_drawer.dart';
import 'package:pic_share/views/pages/home/widgets/single_post_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: CustomAppBar(
        title: t.home,
        isLeadingShow: false,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.gridPostView);
            },
            icon: const Icon(Icons.view_comfortable_outlined),
          ),
        ],
      ).show(),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 2),
        ),
        child: CarouselSlider.builder(
          options: CarouselOptions(
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayCurve: Curves.linear,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            initialPage: 0,
            pageSnapping: true,
            autoPlay: false,
            // autoPlay: true,
            height: MediaQuery.of(context).size.height,
            viewportFraction: 1.0,
            enableInfiniteScroll: false,
            autoPlayInterval: const Duration(seconds: 4),
            scrollDirection: Axis.vertical,
            onPageChanged: (
              index,
              reason,
            ) {},
          ),
          itemCount: 12,
          itemBuilder: (context, index, realIndex) {
            return const SinglePostContainer();
          },
        ),
      ),
    );
  }
}
