import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pic_share/data/repositories/posts/post_repository.dart';

class PostWithLocationController extends GetxController {
  var markers = <Marker>[].obs;
  late GoogleMapController mapController;
  Rx<Marker?> selectedMarker = Rx<Marker?>(null);

  PostRepository postRepository;
  PostWithLocationController({required this.postRepository});

  @override
  void onInit() async {
    super.onInit();
    await fetchMemories();
  }

  Future<void> fetchMemories() async {
    final listPosts = await postRepository.getPostsWithLocation();

    markers.value = listPosts.map((post) {
      final String id =
          post.id?.toString() ?? "${post.latitude}${post.longitude}";
      return Marker(
        onTap: () {
          selectedMarker.value = Marker(
            markerId: MarkerId(id),
            position: LatLng(post.latitude ?? 0, post.longitude ?? 0),
            infoWindow: InfoWindow(
              title: post.caption,
              snippet: post.urlImage,
            ),
          );
        },
        markerId: MarkerId(id),
        position: LatLng(post.latitude ?? 0, post.longitude ?? 0),
        infoWindow: InfoWindow(
          title: post.caption,
          // snippet:
          //     "${memory['city']}, ${memory['state']}, ${memory['country']}",
        ),
      );
    }).toList();
  }

  void setMapController(GoogleMapController controller) {
    mapController = controller;
  }

  void deselectMarker() {
    selectedMarker.value = null;
  }
}
