import 'package:pic_share/data/models/user/user_summary_model.dart';
import 'package:pic_share/data/providers/network/api_provider.dart';
import 'package:pic_share/data/providers/network/api_request_representable.dart';
import 'package:pic_share/data/providers/network/api_response.dart';

class GetUserLikeAPI extends APIRequestRepresentable<List<UserSummaryModel>> {
  final int id;
  GetUserLikeAPI({required this.id});
  @override
  String get endpoint => '/api/post/$id/likers';

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  List<UserSummaryModel> Function(dynamic p1) get fromJson => (json) {
        if (json is Map<String, dynamic>) {
          final listUser = json['user_likes'] as List<dynamic>;
          final listUserSummary =
              listUser.map((e) => UserSummaryModel.fromJson(e)).toList();
          return listUserSummary;
        }
        return [];
      };

  @override
  Future<ApiResponse<List<UserSummaryModel>>> request() {
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
  Function(dynamic json) get fromJson => (json) {
        return json;
      };

  @override
  Future<ApiResponse> request() {
    return APIProvider().request(this);
  }
}

class DisLikeAPI extends APIRequestRepresentable {
  final int id;
  final int userId;
  DisLikeAPI({required this.id, required this.userId});
  @override
  String get endpoint => '/api/post/$id/dislike_post';

  @override
  HTTPMethod get method => HTTPMethod.delete;
  @override
  get body => {
        "user_id": userId,
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
