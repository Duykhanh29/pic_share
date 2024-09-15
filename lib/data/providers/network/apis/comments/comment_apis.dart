import 'package:pic_share/data/providers/network/api_provider.dart';
import 'package:pic_share/data/providers/network/api_request_representable.dart';

class GetCommentsAPI extends APIRequestRepresentable {
  final int id;
  GetCommentsAPI({required this.id});
  @override
  String get endpoint => '/api/post/$id/comments';

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  Future request() {
    return APIProvider().request(this);
  }
}

class AddCommentAPI extends APIRequestRepresentable {
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
  get body => {'content': content};
  @override
  Future request() {
    return APIProvider().request(this);
  }
}

class AddReplyAPI extends APIRequestRepresentable {
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
  Future request() {
    return APIProvider().request(this);
  }
}
