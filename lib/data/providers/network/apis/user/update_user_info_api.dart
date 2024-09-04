import 'package:dio/dio.dart';
import 'package:pic_share/data/providers/network/api_provider.dart';
import 'package:pic_share/data/providers/network/api_request_representable.dart';

class GetUserInfoAPI extends APIRequestRepresentable {
  @override
  String get endpoint => '/api/user';

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  Future request() {
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
  Future request() {
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
  Future request() {
    return APIProvider().request(this);
  }
}

class DeleteUserAccAPI extends APIRequestRepresentable {
  @override
  String get endpoint => '/api/user/delete';

  @override
  HTTPMethod get method => HTTPMethod.delete;

  @override
  Future request() {
    return APIProvider().request(this);
  }
}
