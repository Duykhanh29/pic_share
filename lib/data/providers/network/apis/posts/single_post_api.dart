import 'package:dio/dio.dart';
import 'package:pic_share/data/models/post/report.dart';
import 'package:pic_share/data/providers/network/api_provider.dart';
import 'package:pic_share/data/providers/network/api_request_representable.dart';
import 'package:pic_share/data/models/post/post.dart';
import 'package:pic_share/data/providers/network/api_response.dart';
import 'package:pic_share/data/models/post/post_detail.dart';

class CreatePostAPI extends APIRequestRepresentable<Post?> {
  CreatePostAPI({
    required this.formData,
  });
  FormData formData;
  @override
  String get endpoint => '/api/post/create';

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  get body {
    return formData;
  }

  @override
  Post? Function(dynamic p1) get fromJson => (json) {
        if (json == null) return null;
        if (json is List) {
          return Post.fromJson(json[0]);
        }
        return Post.fromJson(json);
      };

  @override
  Future<ApiResponse<Post?>> request() {
    return APIProvider().request(this);
  }
}

class PostDetailAPI extends APIRequestRepresentable<PostDetail?> {
  int id;
  PostDetailAPI({required this.id});
  @override
  String get endpoint => '/api/post/$id';

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  PostDetail? Function(dynamic p1) get fromJson => (json) {
        if (json == null) return null;
        if (json is List) {
          return PostDetail.fromJson(json[0]);
        }
        return PostDetail.fromJson(json);
      };

  @override
  Future<ApiResponse<PostDetail?>> request() {
    return APIProvider().request(this);
  }
}

class DeletePostAPI extends APIRequestRepresentable {
  final int id;
  DeletePostAPI({required this.id});
  @override
  String get endpoint => '/api/post/delete/$id';

  @override
  HTTPMethod get method => HTTPMethod.delete;

  @override
  Function(dynamic json) get fromJson => (json) {
        return json;
      };

  @override
  Future<ApiResponse> request() {
    return APIProvider().request(this);
  }
}

class GetPostHistoryAPI extends APIRequestRepresentable {
  GetPostHistoryAPI({this.page, this.userId});
  final int? page;
  final int? userId;
  @override
  String get endpoint => userId != null
      ? '/api/post/post_histories?user_id=$userId?page=$page'
      : '/api/post/post_histories?page=$page';

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  Function(dynamic json) get fromJson => (json) {
        return json as Map<String, dynamic>;
      };

  @override
  Future<ApiResponse> request() {
    return APIProvider().request(this);
  }
}

class ReportPostAPI extends APIRequestRepresentable<Report?> {
  ReportPostAPI({required this.id, required this.reason});
  final int id;
  final String reason;
  @override
  String get endpoint => '/api/post/$id/report';

  @override
  HTTPMethod get method => HTTPMethod.post;
  @override
  get body => {
        'reason': reason,
      };

  @override
  Report? Function(dynamic p1) get fromJson => (json) {
        if (json == null) return null;
        if (json is List) {
          return Report.fromJson(json[0]);
        }
        return Report.fromJson(json);
      };

  @override
  Future<ApiResponse<Report?>> request() {
    return APIProvider().request(this);
  }
}
