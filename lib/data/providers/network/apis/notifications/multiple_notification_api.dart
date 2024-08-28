import 'package:pic_share/data/providers/network/api_provider.dart';
import 'package:pic_share/data/providers/network/api_request_representable.dart';

class MultipleNotificationAPI extends APIRequestRepresentable {
  MultipleNotificationAPI({required this.tokens});
  List<String> tokens;
  @override
  String get endpoint {
    return '/api/send_bulk_notification';
  }

  @override
  get body => {
        'fcm_tokens': tokens.map((e) => e.toString()).toList(),
      };

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  Future request() {
    return APIProvider().request(this);
  }
}
