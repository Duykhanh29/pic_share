import 'package:pic_share/data/models/user/user_summary_model.dart';
import 'package:pic_share/data/providers/network/api_response.dart';
import 'package:pic_share/data/providers/network/apis/search/search_api.dart';

abstract class SearchRepository {
  Future<ApiResponse<List<UserSummaryModel>>> searchByName(
      {required String name});

  Future<ApiResponse<UserSummaryModel?>> searchByUserCode(
      {required String code});
}

class SearchRepositoryImpl implements SearchRepository {
  @override
  Future<ApiResponse<List<UserSummaryModel>>> searchByName(
      {required String name}) async {
    final response = await SearchByNameAPI(name: name).request();
    return response;
  }

  @override
  Future<ApiResponse<UserSummaryModel?>> searchByUserCode(
      {required String code}) async {
    final response = await SearchUserCodeAPI(code: code).request();
    return response;
  }
}
