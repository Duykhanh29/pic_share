import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:pic_share/data/enums/shared_post_type.dart';
import 'package:pic_share/data/models/post/post.dart';
import 'package:pic_share/data/models/post/post_detail.dart';
import 'package:pic_share/data/models/post/report.dart';
import 'package:pic_share/data/models/user/user_summary_model.dart';
import 'package:pic_share/data/providers/network/api_response.dart';
import 'package:pic_share/data/providers/network/apis/posts/get_posts_for_user_api.dart';
import 'package:pic_share/data/providers/network/apis/posts/get_user_like_api.dart';
import 'package:pic_share/data/providers/network/apis/posts/get_viewer_api.dart';
import 'package:pic_share/data/providers/network/apis/posts/single_post_api.dart';
import 'package:pic_share/data/models/paging.dart';

abstract class PostRepository {
  Future<ApiResponse<Post?>> createPost({
    required File urlImage,
    String? caption,
    List<int> shareWiths = const [],
    required SharedPostType type,
    double? latitude,
    double? longitude,
  });
  Future<Paging<Post>> getPostHistory({int? page, int? userId});
  Future<ApiResponse<PostDetail?>> getPostDetail(int id);
  Future<ApiResponse> deletePost(int id);
  Future<ApiResponse<Report?>> reportPost(
      {required int id, required String reason});
  //
  Future<ApiResponse<List<UserSummaryModel>>> getUserLikes(int id);
  Future<ApiResponse<List<UserSummaryModel>>> getUserViews(int id);
  Future<ApiResponse> addNewUserLike(int id);
  Future<ApiResponse> addNewUserView(int id);
  Future<ApiResponse> dislikePost({required int id, required int userId});
  Future<ApiResponse<List<PostDetail>>> getPostsForUser({int? userId});
  Future<ApiResponse<List<PostDetail>>> getPostsWithLocation();
}

class PostRepositoryImpl implements PostRepository {
  @override
  Future<ApiResponse<Post?>> createPost({
    required File urlImage,
    String? caption,
    List<int> shareWiths = const [],
    required SharedPostType type,
    double? latitude,
    double? longitude,
  }) async {
    FormData formData = FormData.fromMap({
      "url_image": await MultipartFile.fromFile(
        urlImage.path,
        filename: basename(urlImage.path),
      ),
      "caption": caption,
      "type": type.value,
      if (latitude != null && latitude != 0.0) "latitude": latitude,
      if (longitude != null && longitude != 0.0) "longitude": longitude,
      // ...sharedWithData,
    });

    if (shareWiths.isNotEmpty) {
      for (int id in shareWiths) {
        formData.fields.add(MapEntry('shared_with[]', id.toString()));
      }
    }

    final response = await CreatePostAPI(formData: formData).request();
    return response;
  }

  @override
  Future<ApiResponse<PostDetail?>> getPostDetail(int id) async {
    final response = await PostDetailAPI(id: id).request();
    return response;
  }

  @override
  Future<Paging<Post>> getPostHistory({int? page, int? userId}) async {
    try {
      final response =
          await GetPostHistoryAPI(page: page, userId: userId).request();
      final data = response.data as Map<String, dynamic>;
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
  Future<ApiResponse> addNewUserLike(int id) async {
    final response = await AddNewLikeAPI(id: id).request();
    return response;
  }

  @override
  Future<ApiResponse> addNewUserView(int id) async {
    final response = await AddNewViewAPI(id: id).request();
    return response;
  }

  @override
  Future<ApiResponse<List<UserSummaryModel>>> getUserLikes(int id) async {
    final response = await GetUserLikeAPI(id: id).request();
    return response;
  }

  @override
  Future<ApiResponse<List<UserSummaryModel>>> getUserViews(int id) async {
    final response = await GetViewerAPI(id: id).request();
    return response;
  }

  @override
  Future<ApiResponse> deletePost(int id) async {
    final response = await DeletePostAPI(id: id).request();
    return response;
  }

  @override
  Future<ApiResponse<Report?>> reportPost(
      {required int id, required String reason}) async {
    final response = await ReportPostAPI(id: id, reason: reason).request();
    return response;
  }

  @override
  Future<ApiResponse<List<PostDetail>>> getPostsForUser({int? userId}) async {
    final response = await GetPostsForUserAPI(userId: userId).request();
    return response;
  }

  @override
  Future<ApiResponse> dislikePost(
      {required int id, required int userId}) async {
    final response = await DisLikeAPI(id: id, userId: userId).request();
    return response;
  }

  @override
  Future<ApiResponse<List<PostDetail>>> getPostsWithLocation() async {
    final response = await GetPostWithLocationAPI().request();

    return response;
  }
}
