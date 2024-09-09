import 'package:pic_share/data/providers/network/api_provider.dart';
import 'package:pic_share/data/providers/network/api_request_representable.dart';

class GetViewerAPI extends APIRequestRepresentable {
  final int id;
  GetViewerAPI({required this.id});
  @override
  String get endpoint => '/api/post/$id/viewers';

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  Future request() {
    return APIProvider().request(this);
  }
}

class AddNewViewAPI extends APIRequestRepresentable {
  final int id;
  AddNewViewAPI({required this.id});
  @override
  String get endpoint => '/api/post/$id/new_viewer';

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  Future request() {
    return APIProvider().request(this);
  }
}
