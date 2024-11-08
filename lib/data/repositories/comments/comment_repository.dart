import 'package:pic_share/data/models/comment/comment.dart';
import 'package:pic_share/data/models/comment/reply.dart';
import 'package:pic_share/data/providers/network/api_response.dart';
import 'package:pic_share/data/providers/network/apis/comments/comment_apis.dart';

abstract class CommentRepository {
  Future<ApiResponse<List<Comment>>> getComments(int id);
  Future<ApiResponse<Comment?>> addComment(
      {required int id, required String content});
  Future<ApiResponse<Reply?>> addReply(
      {required int id, required int cmtId, required String content});
}

class CommentRepositoryImpl implements CommentRepository {
  @override
  Future<ApiResponse<List<Comment>>> getComments(int id) async {
    final response = await GetCommentsAPI(id: id).request();
    return response;
  }

  @override
  Future<ApiResponse<Comment?>> addComment(
      {required int id, required String content}) async {
    final response = await AddCommentAPI(id: id, content: content).request();
    return response;
  }

  @override
  Future<ApiResponse<Reply?>> addReply(
      {required int id, required int cmtId, required String content}) async {
    final response =
        await AddReplyAPI(id: id, cmtId: cmtId, content: content).request();
    return response;
  }
}
