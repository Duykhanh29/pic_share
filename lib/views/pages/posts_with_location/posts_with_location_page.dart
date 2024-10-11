import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pic_share/app/custom/app_bar_custom.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/view_model/posts_with_location/posts_with_location_controller.dart';
import 'package:pic_share/views/pages/posts_with_location/widgets/custom_info_window.dart';

class PostsWithLocationPage extends GetView<PostWithLocationController> {
  const PostsWithLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: t.postsWithLocation,
      ).show(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            Obx(
              () => GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(0, 0),
                  zoom: 2,
                ),
                markers: Set<Marker>.of(controller.markers),
                onMapCreated: controller.setMapController,
                onTap: (LatLng position) {
                  controller.deselectMarker();
                },
              ),
            ),
            Obx(
              () {
                if (controller.selectedMarker.value != null) {
                  return Positioned(
                    top: 100,
                    left: 50,
                    right: 50,
                    child: CustomInfoWindow(
                        marker: controller.selectedMarker.value!),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
