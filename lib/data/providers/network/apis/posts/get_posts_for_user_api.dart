import 'package:pic_share/data/providers/network/api_provider.dart';
import 'package:pic_share/data/providers/network/api_request_representable.dart';

class GetPostsForUserAPI extends APIRequestRepresentable {
  int? userId;

  GetPostsForUserAPI({this.userId});
  @override
  String get endpoint => userId != null
      ? '/api/post/posts_for_user?friend_id=$userId'
      : '/api/post/posts_for_user';

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  Future request() {
    return APIProvider().request(this);
  }
}
