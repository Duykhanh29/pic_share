import 'package:pic_share/data/providers/network/api_provider.dart';
import 'package:pic_share/data/providers/network/api_request_representable.dart';

class GetNotificationAPI extends APIRequestRepresentable {
  final int page;
  GetNotificationAPI({this.page = 1});
  @override
  String get endpoint {
    return '/api/notifications?page=$page';
  }

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  Future request() {
    return APIProvider().request(this);
  }
}

class UpdateUnseenNotificationAPI extends APIRequestRepresentable {
  @override
  String get endpoint => '/api/notifications/update_unseen_notification';

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  Future request() {
    return APIProvider().request(this);
  }
}
