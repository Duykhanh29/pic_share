import 'package:pic_share/data/models/user/user_summary_model.dart';
import 'package:pic_share/data/providers/network/api_provider.dart';
import 'package:pic_share/data/providers/network/api_request_representable.dart';
import 'package:pic_share/data/providers/network/api_response.dart';

class GetViewerAPI extends APIRequestRepresentable<List<UserSummaryModel>> {
  final int id;
  GetViewerAPI({required this.id});
  @override
  String get endpoint => '/api/post/$id/viewers';

  @override
  HTTPMethod get method => HTTPMethod.get;
  @override
  List<UserSummaryModel> Function(dynamic p1) get fromJson => (json) {
        if (json is Map<String, dynamic>) {
          return (json['user_views'] as List)
              .map((e) => UserSummaryModel.fromJson(e))
              .toList();
        }
        return [];
      };
  @override
  Future<ApiResponse<List<UserSummaryModel>>> request() {
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
  Function(dynamic json) get fromJson => (json) {
        return json;
      };

  @override
  Future<ApiResponse> request() {
    return APIProvider().request(this);
  }
}
