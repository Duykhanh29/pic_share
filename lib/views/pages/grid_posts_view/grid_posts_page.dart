import 'package:flutter/material.dart';
import 'package:pic_share/app/custom/app_bar_custom.dart';
import 'package:pic_share/app/helper/image_cache_helper.dart';
import 'package:pic_share/views/components/app_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GridPostPage extends StatelessWidget {
  const GridPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: CustomAppBar(title: t.home).show(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {},
              child: ImageCacheHelper.showImage(
                  url:
                      "https://mrwallpaper.com/images/hd/beautiful-pink-tree-3vau5vtfa3qn7k8v.jpg",
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.3),
            );
          },
          itemCount: 45,
        ),
      ),
    );
  }
}
