import 'package:pic_share/data/models/user/user_log.dart';
import 'package:pic_share/data/providers/network/api_provider.dart';
import 'package:pic_share/data/providers/network/api_request_representable.dart';
import 'package:pic_share/data/providers/network/api_response.dart';

class UserLogAPI extends APIRequestRepresentable<UserLog?> {
  final int? userId;
  UserLogAPI({this.userId});
  @override
  String get endpoint =>
      userId != null ? '/api/user_logs?user_id=$userId' : '/api/user_logs';

  @override
  HTTPMethod get method => HTTPMethod.get;
  @override
  UserLog? Function(dynamic p1) get fromJson => (json) {
        if (json == null) return null;
        if (json is List) {
          return UserLog.fromJson(json[0]);
        }
        return UserLog.fromJson(json);
      };

  @override
  Future<ApiResponse<UserLog?>> request() {
    return APIProvider().request(this);
  }
}
