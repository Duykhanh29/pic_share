import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pic_share/app/config/app_config.dart';

class CustomInfoWindow extends StatelessWidget {
  final Marker marker;

  const CustomInfoWindow({super.key, required this.marker});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(marker.infoWindow.title ?? "No Title"),
            const SizedBox(height: 5),
            marker.infoWindow.snippet != null
                ? Image.network(
                    AppConfig.baseUrl + marker.infoWindow.snippet!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 5),
            Text(marker.infoWindow.snippet ?? "No details"),
          ],
        ),
      ),
    );
  }
}
