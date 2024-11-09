import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/strings.dart';
import 'package:pic_share/data/models/post/post_detail.dart';
import 'package:pic_share/data/models/post/post_marker.dart';
import 'package:pic_share/data/repositories/posts/post_repository.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:pic_share/routes/app_pages.dart';
import 'package:pic_share/views/pages/posts_location/widgets/window_info_widget.dart';

class PostsLocationController extends GetxController {
  RxList<Marker> markers = <Marker>[].obs;
  Rx<PostMarker?> selectedMarker = Rx<PostMarker?>(null);
  RxList<PostDetail> posts = <PostDetail>[].obs;
  Rx<PostDetail?> selectedPost = Rx<PostDetail?>(null);
  RxBool isLoading = true.obs;
  late MapController mapController;

  PostRepository postRepository;
  PostsLocationController({required this.postRepository}) {
    if (Get.arguments != null) {
      selectedPost.value = Get.arguments[Strings.postDetail] as PostDetail?;
    }
  }

  @override
  void onInit() async {
    mapController = MapController();
    if (selectedPost.value != null) {
      fetchPostDetailMaker();
    } else {
      await fetchMemories();
    }

    super.onInit();
  }

  @override
  void onClose() {
    mapController.dispose();
    super.onClose();
  }

  void fetchPostDetailMaker() {
    if (selectedPost.value != null) {
      markers.value = [
        Marker(
          point: LatLng(selectedPost.value!.latitude ?? 0,
              selectedPost.value!.longitude ?? 0),
          builder: (context) {
            final post = selectedPost.value!;
            final String id =
                post.id?.toString() ?? "${post.latitude}${post.longitude}";
            return GestureDetector(
              onTap: () {
                selectedMarker.value = PostMarker(
                  title: post.caption,
                  imageUrl: post.urlImage,
                  details: id,
                  position: LatLng(post.latitude ?? 0, post.longitude ?? 0),
                );
                _showInfoBottomSheet(
                  context: context,
                  title: post.caption,
                  imageUrl: post.urlImage,
                  details: 'Details about ${post.caption}',
                  postId: post.id ?? 0,
                  isShowActionRow: false,
                );
              },
              child: const Icon(
                Icons.location_on,
                size: 40.0,
                color: Colors.red,
              ),
            );
          },
        )
      ];
    }
    isLoading.value = false;
  }

  Future<void> fetchMemories() async {
    List<PostDetail> listPosts = [];
    final response = await postRepository.getPostsWithLocation();
    if (response.isSuccess) {
      listPosts = response.data ?? [];
    }
    posts.value = listPosts;

    markers.value = listPosts.map((post) {
      final String id =
          post.id?.toString() ?? "${post.latitude}${post.longitude}";
      return Marker(
        point: LatLng(post.latitude ?? 0, post.longitude ?? 0),
        builder: (ctx) => GestureDetector(
          onTap: () {
            selectedMarker.value = PostMarker(
              title: post.caption,
              imageUrl: post.urlImage,
              details: id,
              position: LatLng(post.latitude ?? 0, post.longitude ?? 0),
            );
            _showInfoBottomSheet(
              context: ctx,
              title: post.caption,
              imageUrl: post.urlImage,
              details: 'Details about ${post.caption}',
              postId: post.id ?? 0,
            );
          },
          child: const Icon(
            Icons.location_on,
            size: 40.0,
            color: Colors.red,
          ),
        ),
      );
    }).toList();
    isLoading.value = false;
  }

  void _showInfoBottomSheet({
    required BuildContext context,
    required String? title,
    required String? imageUrl,
    required String? details,
    required int postId,
    bool isShowActionRow = true,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return WindowInfoWidget(
          title: title,
          imageUrl: imageUrl,
          details: details,
          onTap: () {
            onNavToDetailPost(postId);
          },
          isShowActionRow: isShowActionRow,
        );
      },
    );
  }

  void onNavToDetailPost(int postId) {
    Get.toNamed(Routes.postDetail, arguments: {
      Strings.postId: postId,
    });
  }

  void deselectMarker() {
    selectedMarker.value = null;
  }
}
