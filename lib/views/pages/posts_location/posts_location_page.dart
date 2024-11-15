import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:pic_share/app/custom/app_bar_custom.dart';
import 'package:pic_share/view_model/posts_location/posts_location_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pic_share/views/widgets/loading_widget.dart';
import 'package:pic_share/views/widgets/asset_image_widget.dart';
import 'package:pic_share/app/constants/app_images.dart';

class PostsLocationPage extends GetView<PostsLocationController> {
  const PostsLocationPage({super.key});

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
            _buildMap(context, t),
            _buildZoomButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildMap(BuildContext context, AppLocalizations t) {
    final size = MediaQuery.of(context).size.height;
    return Obx(() {
      final markers = controller.markers.toList();
      return controller.isLoading.value
          ? const LoadingWidget()
          : markers.isNotEmpty
              ? FlutterMap(
                  mapController: controller.mapController,
                  options: MapOptions(
                    center: LatLng(
                      markers[0].point.latitude,
                      markers[0].point.longitude,
                    ),
                    zoom: 8,
                    onTap: (_, __) {
                      controller
                          .deselectMarker(); // Deselect when tapping on the map
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: const ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: markers,
                    ),
                  ],
                )
              : SizedBox(
                  height: size * 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AssetImageWidget(asset: AppImage.emptyPhoto),
                      SizedBox(
                        height: size * 0.04,
                      ),
                      Center(
                        child: Text(t.noPosts),
                      ),
                    ],
                  ),
                );
    });
  }

  Widget _buildZoomButtons() {
    return Obx(
      () {
        final markers = controller.markers.toList();
        return markers.isNotEmpty
            ? Positioned(
                bottom: 20,
                right: 20,
                child: Column(
                  children: [
                    FloatingActionButton(
                      heroTag: 'zoom_in',
                      onPressed: () {
                        controller.mapController.move(
                          controller.mapController.center,
                          controller.mapController.zoom + 1,
                        );
                      },
                      child: const Icon(Icons.zoom_in),
                    ),
                    const SizedBox(height: 10),
                    FloatingActionButton(
                      heroTag: 'zoom_out',
                      onPressed: () {
                        controller.mapController.move(
                          controller.mapController.center,
                          controller.mapController.zoom - 1,
                        );
                      },
                      child: const Icon(Icons.zoom_out),
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
