import 'package:pic_share/data/models/post/post_detail.dart';
import 'package:pic_share/data/providers/network/api_provider.dart';
import 'package:pic_share/data/providers/network/api_request_representable.dart';
import 'package:pic_share/data/providers/network/api_response.dart';

class GetPostsForUserAPI extends APIRequestRepresentable<List<PostDetail>> {
  int? userId;

  GetPostsForUserAPI({this.userId});
  @override
  String get endpoint => userId != null
      ? '/api/post/posts_for_user?friend_id=$userId'
      : '/api/post/posts_for_user';

  @override
  HTTPMethod get method => HTTPMethod.get;
  @override
  List<PostDetail> Function(dynamic p1) get fromJson => (json) {
        if (json is Map<String, dynamic>) {
          return (json['posts'] as List)
              .map((e) => PostDetail.fromJson(e))
              .toList();
        }
        return [];
      };

  @override
  Future<ApiResponse<List<PostDetail>>> request() {
    return APIProvider().request(this);
  }
}

class GetPostWithLocationAPI extends APIRequestRepresentable<List<PostDetail>> {
  @override
  String get endpoint => '/api/post/posts_with_geolocation';

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  List<PostDetail> Function(dynamic p1) get fromJson => (json) {
        return (json as List).map((e) => PostDetail.fromJson(e)).toList();
      };
  @override
  Future<ApiResponse<List<PostDetail>>> request() {
    return APIProvider().request(this);
  }
}
