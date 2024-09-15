import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pic_share/app/constants/strings.dart';
import 'package:pic_share/data/models/paging.dart';
import 'package:pic_share/data/models/post/post.dart';
import 'package:pic_share/data/repositories/posts/post_repository.dart';
import 'package:pic_share/routes/app_pages.dart';
import 'package:pic_share/view_model/profile/profile_controller.dart';

class PostHistoryController extends GetxController {
  PostRepository postRepository;
  ProfileController profileController;
  PostHistoryController(
      {required this.postRepository, required this.profileController});
  RxList<Post> posts = <Post>[].obs;
  RxBool isLoading = true.obs;

  final PagingController<int, Post> pagingController =
      PagingController<int, Post>(
    firstPageKey: 1,
  );
  @override
  void onInit() async {
    pagingController.addPageRequestListener((pageKey) async {
      await fetchPosts(page: pageKey);
    });
    await fetchPosts();
    super.onInit();
  }

  Future<void> fetchPosts({int page = 1}) async {
    isLoading.value = true;
    try {
      Paging<Post> paging = await postRepository.getPostHistory(page);
      final posts = paging.data;
      if (paging.hasMore) {
        pagingController.appendPage(
          posts,
          paging.pageNumber! + 1,
        );
      } else {
        pagingController.appendLastPage(posts);
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  void onClick(int index) async {
    final postId = pagingController.itemList?[index].id;
    final result = await Get.toNamed(Routes.postDetail, arguments: {
      Strings.postId: postId,
    });
    if (result == true && postId != null) {
      final updatedList = pagingController.itemList
          ?.where((post) => post.id != postId)
          .toList();
      pagingController.itemList = updatedList;
      await profileController.fetchData();
    }
  }
}
