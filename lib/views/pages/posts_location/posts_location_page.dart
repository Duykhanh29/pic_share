import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:pic_share/app/custom/app_bar_custom.dart';
import 'package:pic_share/view_model/posts_location/posts_location_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            _buildMap(),
            _buildZoomButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildMap() {
    return Obx(() {
      final markers = controller.markers.toList();
      return markers.isNotEmpty
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
          : const SizedBox.shrink();
    });
  }

  Widget _buildZoomButtons() {
    return Positioned(
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
    );
  }
}
