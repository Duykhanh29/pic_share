import 'package:pic_share/data/providers/network/api_provider.dart';
import 'package:pic_share/data/providers/network/api_request_representable.dart';
import 'package:pic_share/data/providers/network/api_response.dart';

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
  Function(dynamic json) get fromJson => (json) {
        return json;
      };

  @override
  Future<ApiResponse> request() {
    return APIProvider().request(this);
  }
}
