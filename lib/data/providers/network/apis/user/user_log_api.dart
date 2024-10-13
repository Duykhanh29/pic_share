import 'package:pic_share/data/providers/network/api_provider.dart';
import 'package:pic_share/data/providers/network/api_request_representable.dart';

class UserLogAPI extends APIRequestRepresentable {
  final int? userId;
  UserLogAPI({this.userId});
  @override
  String get endpoint =>
      userId != null ? '/api/user_logs?user_id=$userId' : '/api/user_logs';

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  Future request() {
    return APIProvider().request(this);
  }
}
