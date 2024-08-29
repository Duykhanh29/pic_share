import 'package:pic_share/data/providers/network/api_provider.dart';
import 'package:pic_share/data/providers/network/api_request_representable.dart';

class NotificationAPI extends APIRequestRepresentable {
  NotificationAPI({required this.token});
  String token;
  @override
  String get endpoint {
    return '/api/send_notification';
  }

  @override
  get body => {
        'fcm_token': token,
      };

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  Future request() {
    return APIProvider().request(this);
  }
}
