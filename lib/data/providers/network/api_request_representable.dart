import 'package:pic_share/app/config/app_config.dart';

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

abstract class APIRequestRepresentable {
  HTTPMethod get method;
  Map<String, String>? get headers => null;

  String get url => baseUrl + endpoint;

  String get baseUrl => AppConfig.baseUrl;
  Map<String, dynamic>? get query => null;
  String get endpoint;
  dynamic get body => null;
  Future request();
}
