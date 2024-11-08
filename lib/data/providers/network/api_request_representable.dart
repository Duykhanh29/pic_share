import 'package:pic_share/app/config/app_config.dart';
import 'package:pic_share/data/providers/network/api_response.dart';

enum HTTPMethod { get, post, delete, put, patch }

extension HTTPMethodString on HTTPMethod {
  String get string {
    switch (this) {
      case HTTPMethod.get:
        return "get";
      case HTTPMethod.post:
        return "post";
      case HTTPMethod.delete:
        return "delete";
      case HTTPMethod.patch:
        return "patch";
      case HTTPMethod.put:
        return "put";
    }
  }
}

abstract class APIRequestRepresentable<T> {
  HTTPMethod get method;
  Map<String, String>? get headers => null;

  String get url => baseUrl + endpoint;

  String get baseUrl => AppConfig.baseUrl;
  Map<String, dynamic>? get query => null;
  String get endpoint;
  dynamic get body => null;
  T Function(dynamic json) get fromJson;
  Future<ApiResponse<T>> request();
}
