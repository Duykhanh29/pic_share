import 'package:pic_share/data/providers/network/api_provider.dart';
import 'package:pic_share/data/providers/network/api_request_representable.dart';

class UpdateFcmTokenAPI extends APIRequestRepresentable {
  UpdateFcmTokenAPI({required this.fcmToken});
  String fcmToken;
  @override
  String get endpoint => '/api/set_fcm_token';

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  get body => {'fcm_token': fcmToken};

  @override
  Future request() {
    return APIProvider().request(this);
  }
}
