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

class RegisterAPI extends APIRequestRepresentable {
  RegisterAPI(
      {required this.email,
      required this.name,
      required this.password,
      required this.passwordConfirmation});
  String name;
  String email;
  String password;
  String passwordConfirmation;
  @override
  String get endpoint => '/api/register';

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  get body => {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation
      };

  @override
  Future request() {
    return APIProvider().request(this);
  }
}

class LoginAPI extends APIRequestRepresentable {
  LoginAPI({
    required this.email,
    required this.password,
  });
  String email;
  String password;
  @override
  String get endpoint => '/api/login';

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  get body => {
        'email': email,
        'password': password,
      };

  @override
  Future request() {
    return APIProvider().request(this);
  }
}

class LoginWithGoogleAPI extends APIRequestRepresentable {
  LoginWithGoogleAPI({required this.accessToken});
  final String accessToken;
  @override
  String get endpoint => '/api/auth/callback';

  @override
  HTTPMethod get method => HTTPMethod.post;
  @override
  get body => {'access_token': accessToken};

  @override
  Future request() {
    return APIProvider().request(this);
  }
}

class LogoutAPI extends APIRequestRepresentable {
  LogoutAPI();

  @override
  String get endpoint => '/api/logout';

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  Future request() {
    return APIProvider().request(this);
  }
}
