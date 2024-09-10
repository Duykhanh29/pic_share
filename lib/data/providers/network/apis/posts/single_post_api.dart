import 'package:dio/dio.dart';
import 'package:pic_share/data/providers/network/api_provider.dart';
import 'package:pic_share/data/providers/network/api_request_representable.dart';

class CreatePostAPI extends APIRequestRepresentable {
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
  Future request() {
    return APIProvider().request(this);
  }
}

class PostDetailAPI extends APIRequestRepresentable {
  int id;
  PostDetailAPI({required this.id});
  @override
  String get endpoint => '/api/post/$id';

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  Future request() {
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
  Future request() {
    return APIProvider().request(this);
  }
}

class GetPostHistoryAPI extends APIRequestRepresentable {
  GetPostHistoryAPI({this.page});
  final int? page;
  @override
  String get endpoint => '/api/post/post_histories?page=$page';

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  Future request() {
    return APIProvider().request(this);
  }
}

class ReportPostAPI extends APIRequestRepresentable {
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
  Future request() {
    return APIProvider().request(this);
  }
}
