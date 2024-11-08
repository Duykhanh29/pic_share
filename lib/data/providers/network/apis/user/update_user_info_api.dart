import 'package:dio/dio.dart';
import 'package:pic_share/data/models/user/user_model.dart';
import 'package:pic_share/data/providers/network/api_provider.dart';
import 'package:pic_share/data/providers/network/api_request_representable.dart';
import 'package:pic_share/data/providers/network/api_response.dart';

class GetUserInfoAPI extends APIRequestRepresentable<UserModel?> {
  @override
  String get endpoint => '/api/user';

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  UserModel? Function(dynamic p1) get fromJson => (json) {
        if (json == null) return null;
        if (json is List) {
          return UserModel.fromJson(json[0]);
        }
        return UserModel.fromJson(json);
      };

  @override
  Future<ApiResponse<UserModel?>> request() {
    return APIProvider().request(this);
  }
}

class UpdateUserInfo extends APIRequestRepresentable {
  UpdateUserInfo({required this.formData});
  final FormData formData;
  @override
  String get endpoint => '/api/user/update';

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  get body {
    return formData;
  }

  @override
  Map<String, String>? get headers => {
        "Content-Type": "multipart/form-data",
      };

  @override
  Map<String, dynamic>? get query => {"_method": 'PATCH'};

  @override
  Function(dynamic json) get fromJson => (json) {
        return json as Map<String, dynamic>;
      };

  @override
  Future<ApiResponse> request() {
    return APIProvider().request(this);
  }
}

class ChangePasswordAPI extends APIRequestRepresentable {
  ChangePasswordAPI(
      {required this.currentPassword,
      required this.newPassword,
      required this.passwordConfirmation});
  final String currentPassword;
  final String newPassword;
  final String passwordConfirmation;
  @override
  String get endpoint => '/api/user/update';

  @override
  HTTPMethod get method => HTTPMethod.patch;

  @override
  get body => {
        'old_password': currentPassword,
        'password': newPassword,
        'password_confirmation': passwordConfirmation,
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

class DeleteUserAccAPI extends APIRequestRepresentable {
  @override
  String get endpoint => '/api/user/delete';

  @override
  HTTPMethod get method => HTTPMethod.delete;

  @override
  Function(dynamic json) get fromJson => (json) {
        return json;
      };

  @override
  Future<ApiResponse> request() {
    return APIProvider().request(this);
  }
}

class SetFcmTokenAPI extends APIRequestRepresentable {
  final String? fcmToken;
  SetFcmTokenAPI({required this.fcmToken});
  @override
  String get endpoint => '/api/set_fcm_token';

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  get body => {
        'fcm_token': fcmToken,
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
