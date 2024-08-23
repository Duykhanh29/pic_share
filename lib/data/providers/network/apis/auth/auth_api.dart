import 'package:pic_share/data/providers/network/api_provider.dart';
import 'package:pic_share/data/providers/network/api_request_representable.dart';

enum AuthType { login, logout, register }

class AuthAPI extends APIRequestRepresentable {
  final AuthType type;
  AuthAPI({required this.type});
  @override
  String get endpoint {
    switch (type) {
      case AuthType.login:
        return 'auth/login';
      case AuthType.logout:
        return 'auth/logout';
      case AuthType.register:
        return 'auth/register';
      default:
        return "";
    }
  }

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  Future request() {
    return APIProvider().request(this);
  }
}
