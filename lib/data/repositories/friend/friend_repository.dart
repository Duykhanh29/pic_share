import 'package:pic_share/data/enums/friend_status.dart';
import 'package:pic_share/data/models/user/friend.dart';
import 'package:pic_share/data/models/user/user_summary_model.dart';
import 'package:pic_share/data/providers/network/api_response.dart';
import 'package:pic_share/data/providers/network/apis/friends/friend_apis.dart';

abstract class FriendRepository {
  Future<ApiResponse<Friend?>> sendFriendRequest(int friendId);
  Future<ApiResponse> updateFriendStatus(
      {required int id, required FriendStatus status});
  Future<ApiResponse> deleteFriend(int id);

  Future<ApiResponse<List<Friend>>> getFriendList();

  Future<ApiResponse<List<Friend>>> getFriendRequestList();

  Future<ApiResponse<List<Friend>>> getFriendRequestSentList();
  Future<ApiResponse<List<UserSummaryModel>>> getMutualFriends(int friendId);
}

class FriendRepositoryImpl implements FriendRepository {
  @override
  Future<ApiResponse<Friend?>> sendFriendRequest(int friendId) async {
    final response = await MakeFriendRequestAPI(friendId: friendId).request();
    return response;
  }

  @override
  Future<ApiResponse> updateFriendStatus(
      {required int id, required FriendStatus status}) async {
    final response =
        await UpdateFriendRequestAPI(id: id, status: status).request();
    return response;
  }

  @override
  Future<ApiResponse> deleteFriend(int id) async {
    final response = await DeleteFriendRequestAPI(id: id).request();
    return response;
  }

  @override
  Future<ApiResponse<List<Friend>>> getFriendList() async {
    final response = await GetListFriendsAPI().request();
    return response;
  }

  @override
  Future<ApiResponse<List<Friend>>> getFriendRequestList() async {
    final response = await GetRequestedFriendsAPI().request();
    return response;
  }

  @override
  Future<ApiResponse<List<Friend>>> getFriendRequestSentList() async {
    final response = await GetSentFriendsAPI().request();
    return response;
  }

  @override
  Future<ApiResponse<List<UserSummaryModel>>> getMutualFriends(
      int friendId) async {
    final response = await GetMutualFriendsAPI(friendId: friendId).request();
    return response;
  }
}
