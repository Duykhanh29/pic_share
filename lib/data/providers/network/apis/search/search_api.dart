import 'package:pic_share/data/providers/network/api_provider.dart';
import 'package:pic_share/data/providers/network/api_request_representable.dart';

class SearchByNameAPI extends APIRequestRepresentable {
  final String name;
  SearchByNameAPI({required this.name});
  @override
  String get endpoint => '/api/search/$name';

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  Future request() {
    return APIProvider().request(this);
  }
}

class SearchUserCodeAPI extends APIRequestRepresentable {
  final String code;
  SearchUserCodeAPI({required this.code});
  @override
  String get endpoint => '/api/usercode/$code';

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  Future request() {
    return APIProvider().request(this);
  }
}
