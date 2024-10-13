import 'package:flutter/material.dart';
import 'package:pic_share/data/enums/friend_status.dart';
import 'package:pic_share/data/models/user/friend.dart';
import 'package:pic_share/data/models/user/user_summary_model.dart';
import 'package:pic_share/data/providers/network/apis/friends/friend_apis.dart';

abstract class FriendRepository {
  Future<Friend?> sendFriendRequest(int friendId);
  Future<void> updateFriendStatus(
      {required int id, required FriendStatus status});
  Future<void> deleteFriend(int id);

  Future<List<Friend>> getFriendList();

  Future<List<Friend>> getFriendRequestList();

  Future<List<Friend>> getFriendRequestSentList();
  Future<List<UserSummaryModel>> getMutualFriends(int friendId);
}

class FriendRepositoryImpl implements FriendRepository {
  @override
  Future<Friend?> sendFriendRequest(int friendId) async {
    try {
      final response = await MakeFriendRequestAPI(friendId: friendId).request();
      debugPrint("Message: ${response['message']}");
      final data = response['data'] as Map<String, dynamic>;
      return Friend.fromJson(data);
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
    return null;
  }

  @override
  Future<void> updateFriendStatus(
      {required int id, required FriendStatus status}) async {
    try {
      final response =
          await UpdateFriendRequestAPI(id: id, status: status).request();
      debugPrint("Message: ${response['message']}");
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }

  @override
  Future<void> deleteFriend(int id) async {
    try {
      final response = await DeleteFriendRequestAPI(id: id).request();
      debugPrint("Message: ${response['message']}");
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }

  @override
  Future<List<Friend>> getFriendList() async {
    try {
      final response = await GetListFriendsAPI().request();
      final data = response['data'] as Map<String, dynamic>;
      final friendsData = data['list_friend'] as List<dynamic>;
      final friends = friendsData.map((e) => Friend.fromJson(e)).toList();
      return friends;
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
    return [];
  }

  @override
  Future<List<Friend>> getFriendRequestList() async {
    try {
      final response = await GetRequestedFriendsAPI().request();
      final data = response['data'] as Map<String, dynamic>;
      final friendsData = data['list_request'] as List<dynamic>;
      final friends = friendsData.map((e) => Friend.fromJson(e)).toList();
      return friends;
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
    return [];
  }

  @override
  Future<List<Friend>> getFriendRequestSentList() async {
    try {
      final response = await GetSentFriendsAPI().request();
      final data = response['data'] as Map<String, dynamic>;
      final friendsData = data['list_request'] as List<dynamic>;
      final friends = friendsData.map((e) => Friend.fromJson(e)).toList();
      return friends;
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
    return [];
  }

  @override
  Future<List<UserSummaryModel>> getMutualFriends(int friendId) async {
    try {
      final response = await GetMutualFriendsAPI(friendId: friendId).request();
      final data = response['data'] as List<dynamic>;
      final friends = data.map((e) => UserSummaryModel.fromJson(e)).toList();
      return friends;
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
    return [];
  }
}
