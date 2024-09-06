import 'package:flutter/material.dart';
import 'package:pic_share/data/models/user/user_summary_model.dart';
import 'package:pic_share/data/providers/network/apis/search/search_api.dart';

abstract class SearchRepository {
  Future<List<UserSummaryModel>> searchByName({required String name});

  Future<UserSummaryModel?> searchByUserCode({required String code});
}

class SearchRepositoryImpl implements SearchRepository {
  @override
  Future<List<UserSummaryModel>> searchByName({required String name}) async {
    try {
      final response = await SearchByNameAPI(name: name).request();
      final data = response['data'] as Map<String, dynamic>;
      final userData = data['users'] as List<dynamic>;
      final listUser =
          userData.map((e) => UserSummaryModel.fromJson(e)).toList();
      return listUser;
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
    return [];
  }

  @override
  Future<UserSummaryModel?> searchByUserCode({required String code}) async {
    try {
      final response = await SearchUserCodeAPI(code: code).request();
      final data = response['data'] as Map<String, dynamic>;
      final userData = data['users'] as List<dynamic>;
      final listUser =
          userData.map((e) => UserSummaryModel.fromJson(e)).toList();
      return listUser[0];
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
    return null;
  }
}
