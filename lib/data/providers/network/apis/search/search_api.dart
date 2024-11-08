import 'package:pic_share/data/models/user/user_summary_model.dart';
import 'package:pic_share/data/providers/network/api_provider.dart';
import 'package:pic_share/data/providers/network/api_request_representable.dart';
import 'package:pic_share/data/providers/network/api_response.dart';

class SearchByNameAPI extends APIRequestRepresentable<List<UserSummaryModel>> {
  final String name;
  SearchByNameAPI({required this.name});
  @override
  String get endpoint => '/api/search/$name';

  @override
  HTTPMethod get method => HTTPMethod.get;
  @override
  List<UserSummaryModel> Function(dynamic p1) get fromJson => (json) {
        final data = json as Map<String, dynamic>;
        final userData = data['users'] as List<dynamic>;
        final listUser =
            userData.map((e) => UserSummaryModel.fromJson(e)).toList();
        return listUser;
      };

  @override
  Future<ApiResponse<List<UserSummaryModel>>> request() {
    return APIProvider().request(this);
  }
}

class SearchUserCodeAPI extends APIRequestRepresentable<UserSummaryModel?> {
  final String code;
  SearchUserCodeAPI({required this.code});
  @override
  String get endpoint => '/api/usercode/$code';

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  UserSummaryModel? Function(dynamic p1) get fromJson => (json) {
        final data = json as Map<String, dynamic>;
        final userData = data['users'] as List<dynamic>;
        final user =
            userData.map((e) => UserSummaryModel.fromJson(e)).toList().first;
        return user;
      };

  @override
  Future<ApiResponse<UserSummaryModel?>> request() {
    return APIProvider().request(this);
  }
}
