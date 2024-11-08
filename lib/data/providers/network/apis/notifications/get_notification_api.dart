import 'package:pic_share/data/providers/network/api_provider.dart';
import 'package:pic_share/data/providers/network/api_request_representable.dart';
import 'package:pic_share/data/providers/network/api_response.dart';

class GetNotificationAPI extends APIRequestRepresentable {
  final int? page;
  GetNotificationAPI({this.page = 1});
  @override
  String get endpoint {
    return '/api/notifications?page=$page';
  }

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

class GetUnseenNotificationAPI extends APIRequestRepresentable {
  @override
  String get endpoint {
    return '/api/notifications/get_unseen_count';
  }

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

class UpdateUnreadNotificationAPI extends APIRequestRepresentable {
  final int id;
  UpdateUnreadNotificationAPI({required this.id});
  @override
  String get endpoint => '/api/notifications/mark_as_read/$id';

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  Function(dynamic json) get fromJson => (json) {
        return json;
      };

  @override
  Future<ApiResponse> request() {
    return APIProvider().request(this);
  }
}

class UpdateUnseenNotificationAPI extends APIRequestRepresentable {
  UpdateUnseenNotificationAPI();
  @override
  String get endpoint => '/api/notifications/mark_as_seen';

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  Function(dynamic json) get fromJson => (json) {
        return json;
      };

  @override
  Future<ApiResponse> request() {
    return APIProvider().request(this);
  }
}
