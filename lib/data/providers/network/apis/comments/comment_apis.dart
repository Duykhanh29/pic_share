import 'package:pic_share/data/models/comment/comment.dart';
import 'package:pic_share/data/models/comment/reply.dart';
import 'package:pic_share/data/providers/network/api_provider.dart';
import 'package:pic_share/data/providers/network/api_request_representable.dart';
import 'package:pic_share/data/providers/network/api_response.dart';

class GetCommentsAPI extends APIRequestRepresentable<List<Comment>> {
  final int id;
  GetCommentsAPI({required this.id});
  @override
  String get endpoint => '/api/post/$id/comments';

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  List<Comment> Function(dynamic p1) get fromJson => (json) {
        if (json == null) return [];
        if (json is Map<String, dynamic>) {
          return (json['listComment'] as List<dynamic>)
              .map((e) => Comment.fromJson(e))
              .toList();
        }
        return [];
      };
  @override
  Future<ApiResponse<List<Comment>>> request() {
    return APIProvider().request(this);
  }
}

class AddCommentAPI extends APIRequestRepresentable<Comment?> {
  final int id;
  final String content;
  AddCommentAPI({
    required this.id,
    required this.content,
  });
  @override
  String get endpoint => '/api/post/$id/comments/create';

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  get body => {
        'content': content,
      };

  @override
  Comment? Function(dynamic p1) get fromJson => (json) {
        if (json == null) return null;
        if (json is Map<String, dynamic>) {
          return Comment.fromJson(json);
        }
        return null;
      };
  @override
  Future<ApiResponse<Comment?>> request() {
    return APIProvider().request(this);
  }
}

class AddReplyAPI extends APIRequestRepresentable<Reply?> {
  final int id;
  final int cmtId;
  final String content;
  AddReplyAPI({
    required this.id,
    required this.cmtId,
    required this.content,
  });
  @override
  String get endpoint => '/api/post/$id/comments/$cmtId/replies';

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  get body => {
        'content': content,
      };
  @override
  Reply? Function(dynamic p1) get fromJson => (json) {
        if (json == null) return null;
        if (json is Map<String, dynamic>) {
          return Reply.fromJson(json);
        }
        return null;
      };
  @override
  Future<ApiResponse<Reply?>> request() {
    return APIProvider().request(this);
  }
}
