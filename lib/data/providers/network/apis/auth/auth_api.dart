import 'package:pic_share/data/models/auth/qrcode_response.dart';
import 'package:pic_share/data/models/user/user_model.dart';
import 'package:pic_share/data/providers/network/api_provider.dart';
import 'package:pic_share/data/providers/network/api_request_representable.dart';
import 'package:pic_share/data/providers/network/api_response.dart';

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
  Function(dynamic json) get fromJson => (json) {
        return json as Map<String, dynamic>;
      };

  @override
  Future<ApiResponse> request() {
    return APIProvider().request(this);
  }
}

class RegisterAPI extends APIRequestRepresentable<UserModel?> {
  RegisterAPI({
    required this.email,
    required this.name,
    required this.password,
    required this.passwordConfirmation,
    this.deviceId,
    this.deviceName,
  });
  String name;
  String email;
  String password;
  String passwordConfirmation;
  String? deviceId;
  String? deviceName;
  @override
  String get endpoint => '/api/register';

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  get body => {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        if (deviceId != null) 'device_id': deviceId,
        if (deviceName != null) 'device_name': deviceName,
      };

  @override
  UserModel? Function(dynamic p1) get fromJson => (json) {
        if (json is List) {
          return json.map((e) => UserModel.fromJson(e)).toList().first;
        }
        return UserModel.fromJson(json);
      };

  @override
  Future<ApiResponse<UserModel?>> request() {
    return APIProvider().request(this);
  }
}

class LoginAPI extends APIRequestRepresentable<UserModel?> {
  LoginAPI({
    required this.email,
    required this.password,
    this.deviceId,
    this.deviceName,
  });
  String email;
  String password;
  String? deviceId;
  String? deviceName;
  @override
  String get endpoint => '/api/login';

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  get body => {
        'email': email,
        'password': password,
        if (deviceId != null) 'device_id': deviceId,
        if (deviceName != null) 'device_name': deviceName,
      };
  @override
  UserModel? Function(dynamic p1) get fromJson => (json) {
        if (json is List) {
          return json.map((e) => UserModel.fromJson(e)).toList().first;
        }
        return UserModel.fromJson(json);
      };

  @override
  Future<ApiResponse<UserModel?>> request() {
    return APIProvider().request(this);
  }
}

class LoginWithGoogleAPI extends APIRequestRepresentable<UserModel?> {
  LoginWithGoogleAPI({required this.accessToken});
  final String accessToken;
  @override
  String get endpoint => '/api/auth/callback';

  @override
  HTTPMethod get method => HTTPMethod.post;
  @override
  get body => {'access_token': accessToken};

  @override
  UserModel? Function(dynamic p1) get fromJson => (json) {
        if (json is List) {
          return json.map((e) => UserModel.fromJson(e)).toList().first;
        }
        return UserModel.fromJson(json);
      };

  @override
  Future<ApiResponse<UserModel?>> request() {
    return APIProvider().request(this);
  }
}

class LogoutAPI extends APIRequestRepresentable {
  final String? deviceId;
  LogoutAPI({this.deviceId});

  @override
  String get endpoint => '/api/logout';

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  get body => {
        if (deviceId != null) 'device_id': deviceId,
      };

  @override
  Function(dynamic json) get fromJson => (json) {
        return json;
      };

  @override
  Future<ApiResponse> request() {
    return APIProvider().request(this);
  }
}

class RefreshTokenApi extends APIRequestRepresentable<String?> {
  String refreshToken;
  RefreshTokenApi({required this.refreshToken});
  @override
  String get endpoint => '/api/auth/refresh_token';

  @override
  Map<String, String>? get headers => {"Authorization": "Bearer $refreshToken"};

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  String? Function(dynamic json) get fromJson => (json) {
        if (json is Map<String, dynamic>) {
          final data = json['access_token'];
          return data;
        }
        return null;
      };

  @override
  Future<ApiResponse<String?>> request() {
    return APIProvider().unsafeCall(this);
  }
}

class Check2FAApi extends APIRequestRepresentable<String?> {
  final String code;
  Check2FAApi({required this.code});
  @override
  String get endpoint => '/api/auth/verify_2fa';

  @override
  String? Function(dynamic json) get fromJson => (json) {
        if (json is Map<String, dynamic>) return json['refresh_token'];
        return null;
      };

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  get body => {
        'code': code,
      };

  @override
  Future<ApiResponse<String?>> request() {
    return APIProvider().request(this);
  }
}

class UpdateState2FAApi extends APIRequestRepresentable<QRCodeResponse?> {
  final String password;
  UpdateState2FAApi({required this.password});
  @override
  String get endpoint => '/api/auth/update_state_2fa';

  @override
  QRCodeResponse? Function(dynamic json) get fromJson => (json) {
        if (json != null && json is Map<String, dynamic>) {
          return QRCodeResponse.fromJson(json);
        }
        return null;
      };

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  get body => {
        'password': password,
      };

  @override
  Future<ApiResponse<QRCodeResponse?>> request() {
    return APIProvider().request(this);
  }
}

class ConfirmEnable2FAApi extends APIRequestRepresentable {
  final String code;
  ConfirmEnable2FAApi({required this.code});
  @override
  String get endpoint => '/api/auth/confirm_enable_2fa';

  @override
  Function(dynamic json) get fromJson => (json) {
        return json;
      };

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  get body => {
        'code': code,
      };

  @override
  Future<ApiResponse> request() {
    return APIProvider().request(this);
  }
}

class ForgotPasswordApi extends APIRequestRepresentable<int> {
  final String email;
  ForgotPasswordApi({required this.email});
  @override
  String get endpoint => '/api/auth/forgot-password';

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  get body => {
        'email': email,
      };

  @override
  Future<ApiResponse<int>> request() {
    return APIProvider().request(this);
  }

  @override
  int Function(dynamic json) get fromJson => (json) {
        if (json is Map<String, dynamic>) {
          final data = json['validity'];
          return data;
        }
        return 0;
      };
}

class ResetPasswordApi extends APIRequestRepresentable {
  final String otp;
  final String email;
  final String password;
  final String confirmPassword;
  ResetPasswordApi({
    required this.otp,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
  @override
  String get endpoint => '/api/auth/reset-password';

  @override
  Function(dynamic json) get fromJson => (json) {
        return json;
      };

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  get body => {
        'otp': otp,
        'password': password,
        'email': email,
        'password_confirmation': confirmPassword,
      };

  @override
  Future<ApiResponse> request() {
    return APIProvider().request(this);
  }
}
