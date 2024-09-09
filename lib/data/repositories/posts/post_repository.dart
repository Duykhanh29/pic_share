import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:pic_share/data/enums/shared_post_type.dart';
import 'package:pic_share/data/models/post/post.dart';
import 'package:pic_share/data/models/post/post_detail.dart';
import 'package:pic_share/data/models/user/user_summary_model.dart';
import 'package:pic_share/data/providers/network/apis/posts/get_user_like_api.dart';
import 'package:pic_share/data/providers/network/apis/posts/get_viewer_api.dart';
import 'package:pic_share/data/providers/network/apis/posts/single_post_api.dart';
import 'package:pic_share/data/models/paging.dart';

abstract class PostRepository {
  Future<Post?> createPost({
    required File urlImage,
    String? caption,
    List<int> shareWiths = const [],
    required SharedPostType type,
  });
  Future<Paging<Post>> getPostHistory(int? page);
  Future<PostDetail?> getPostDetail(int id);
  Future<List<UserSummaryModel>> getUserLikes(int id);
  Future<List<UserSummaryModel>> getUserViews(int id);
  Future<void> addNewUserLike(int id);
  Future<void> addNewUserView(int id);
}

class PostRepositoryImpl implements PostRepository {
  @override
  Future<Post?> createPost({
    required File urlImage,
    String? caption,
    List<int> shareWiths = const [],
    required SharedPostType type,
  }) async {
    try {
      Map<String, dynamic> sharedWithData = {};
      if (shareWiths.isNotEmpty) {
        for (int id in shareWiths) {
          sharedWithData['shared_with[]'] = id.toString();
        }
      }
      FormData formData = FormData.fromMap({
        "url_image": await MultipartFile.fromFile(
          urlImage.path,
          filename: basename(urlImage.path),
        ),
        "caption": caption,
        "type": type,
        ...sharedWithData,
      });

      final response = await CreatePostAPI(formData: formData).request();
      final data = response['data'] as Map<String, dynamic>;
      final post = Post.fromJson(data);
      return post;
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
    return null;
  }

  @override
  Future<PostDetail?> getPostDetail(int id) async {
    try {
      final response = await PostDetailAPI(id: id).request();
      final data = response['data'] as Map<String, dynamic>;
      final post = PostDetail.fromJson(data);
      return post;
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
    return null;
  }

  @override
  Future<Paging<Post>> getPostHistory(int? page) async {
    try {
      final response = await GetPostHistoryAPI(page: page).request();
      final data = response['data'] as Map<String, dynamic>;
      int totalItems = data['totalItems'] as int;
      final postData = data['posts'] as List<dynamic>;
      final posts = postData.map((e) => Post.fromJson(e)).toList();
      final currentPage = (data['currentPage'] as num).toInt();
      final rowsPerPage = (data['perPage'] as num).toInt();
      final lastPage = (data['lastPage'] as num).toInt();
      Paging<Post> paging = Paging(
        totalResults: totalItems,
        data: posts,
        pageNumber: currentPage,
        rowsPerPage: rowsPerPage,
        lastPage: lastPage,
      );
      return paging;
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
    return Paging(
      totalResults: 0,
      data: [],
      pageNumber: 0,
      rowsPerPage: 0,
      lastPage: 0,
    );
  }

  @override
  Future<void> addNewUserLike(int id) async {
    try {
      final response = await AddNewLikeAPI(id: id).request();
      debugPrint("Message: ${response['message']}");
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }

  @override
  Future<void> addNewUserView(int id) async {
    try {
      final response = await AddNewViewAPI(id: id).request();
      debugPrint("Message: ${response['message']}");
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }

  @override
  Future<List<UserSummaryModel>> getUserLikes(int id) async {
    try {} catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
    return [];
  }

  @override
  Future<List<UserSummaryModel>> getUserViews(int id) async {
    try {} catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
    return [];
  }
}
