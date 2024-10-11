import 'package:latlong2/latlong.dart';

class PostMarker {
  final String? title;
  final String? imageUrl;
  final String? details;
  final LatLng position;

  PostMarker({
    required this.title,
    this.imageUrl,
    required this.details,
    required this.position,
  });
}
