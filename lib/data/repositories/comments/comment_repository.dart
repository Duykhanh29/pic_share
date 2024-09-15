import 'package:flutter/foundation.dart';
import 'package:pic_share/data/models/comment/comment.dart';
import 'package:pic_share/data/providers/network/apis/comments/comment_apis.dart';

abstract class CommentRepository {
  Future<List<Comment>> getComments(int id);
  Future<Comment?> addComment({required int id, required String content});
  Future<void> addReply(
      {required int id, required int cmtId, required String content});
}

class CommentRepositoryImpl implements CommentRepository {
  @override
  Future<List<Comment>> getComments(int id) async {
    try {
      final response = await GetCommentsAPI(id: id).request();
      final data = response['data'] as Map<String, dynamic>;
      final listData = data['listComment'] as List<dynamic>;
      final comments = listData.map((e) => Comment.fromJson(e)).toList();
      return comments;
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
    return [];
  }

  @override
  Future<Comment?> addComment(
      {required int id, required String content}) async {
    try {
      final response = await AddCommentAPI(id: id, content: content).request();
      final data = response['data'] as Map<String, dynamic>;
      final comment = Comment.fromJson(data);
      return comment;
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
    return null;
  }

  @override
  Future<void> addReply(
      {required int id, required int cmtId, required String content}) async {
    try {
      final response =
          await AddReplyAPI(id: id, cmtId: cmtId, content: content).request();
      final data = response['data'] as Map<String, dynamic>;
      // final comment = Comment.fromJson(data);
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }
}
