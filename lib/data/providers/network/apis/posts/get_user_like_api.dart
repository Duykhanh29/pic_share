import 'package:pic_share/data/providers/network/api_provider.dart';
import 'package:pic_share/data/providers/network/api_request_representable.dart';

class GetUserLikeAPI extends APIRequestRepresentable {
  final int id;
  GetUserLikeAPI({required this.id});
  @override
  String get endpoint => '/api/post/$id/likers';

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  Future request() {
    return APIProvider().request(this);
  }
}

class AddNewLikeAPI extends APIRequestRepresentable {
  final int id;
  AddNewLikeAPI({required this.id});
  @override
  String get endpoint => '/api/post/$id/new_liker';

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  Future request() {
    return APIProvider().request(this);
  }
}
