import 'package:pic_share/data/enums/friend_status.dart';
import 'package:pic_share/data/models/user/friend.dart';
import 'package:pic_share/data/models/user/suggested_friend.dart';
import 'package:pic_share/data/models/user/user_summary_model.dart';
import 'package:pic_share/data/providers/network/api_provider.dart';
import 'package:pic_share/data/providers/network/api_request_representable.dart';
import 'package:pic_share/data/providers/network/api_response.dart';

class MakeFriendRequestAPI extends APIRequestRepresentable<Friend?> {
  final int friendId;
  MakeFriendRequestAPI({required this.friendId});
  @override
  String get endpoint => '/api/friend/make_friend';

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  get body => {
        'friend_id': friendId,
      };

  @override
  Friend? Function(dynamic p1) get fromJson => (json) {
        if (json == null) return null;
        if (json is List) {
          return Friend.fromJson(json[0]);
        }
        return Friend.fromJson(json);
      };
  @override
  Future<ApiResponse<Friend?>> request() {
    return APIProvider().request(this);
  }
}

class UpdateFriendRequestAPI extends APIRequestRepresentable {
  final int id;
  final FriendStatus status;
  UpdateFriendRequestAPI({required this.id, required this.status});
  @override
  String get endpoint => '/api/friend/update_friend/$id';

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  get body => {
        'status': status.name,
      };

  @override
  Function(dynamic json) get fromJson => (json) => json;

  @override
  Future<ApiResponse> request() {
    return APIProvider().request(this);
  }
}

class DeleteFriendRequestAPI extends APIRequestRepresentable {
  final int id;
  DeleteFriendRequestAPI({required this.id});
  @override
  String get endpoint => '/api/friend/delete_friend/$id';

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  Function(dynamic json) get fromJson => (json) => json;

  @override
  Future<ApiResponse> request() {
    return APIProvider().request(this);
  }
}

class GetListFriendsAPI extends APIRequestRepresentable<List<Friend>> {
  @override
  String get endpoint => '/api/friend/get_friends';

  @override
  HTTPMethod get method => HTTPMethod.get;
  @override
  List<Friend> Function(dynamic p1) get fromJson => (json) {
        if (json == null || json is List) return [];
        if (json is Map<String, dynamic>) {
          final friendsData = json['list_friend'] as List<dynamic>;
          final friends = friendsData.map((e) => Friend.fromJson(e)).toList();
          return friends;
        }
        return [];
      };
  @override
  Future<ApiResponse<List<Friend>>> request() {
    return APIProvider().request(this);
  }
}

class GetRequestedFriendsAPI extends APIRequestRepresentable<List<Friend>> {
  @override
  String get endpoint => '/api/friend/get_requested_friends';

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  List<Friend> Function(dynamic p1) get fromJson => (json) {
        if (json == null || json is List) return [];
        if (json is Map<String, dynamic>) {
          final friendsData = json['list_request'] as List<dynamic>;
          final friends = friendsData.map((e) => Friend.fromJson(e)).toList();
          return friends;
        }
        return [];
      };
  @override
  Future<ApiResponse<List<Friend>>> request() {
    return APIProvider().request(this);
  }
}

class GetSentFriendsAPI extends APIRequestRepresentable<List<Friend>> {
  @override
  String get endpoint => '/api/friend/get_sent_friends';

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  List<Friend> Function(dynamic p1) get fromJson => (json) {
        if (json == null || json is List) return [];
        if (json is Map<String, dynamic>) {
          final friendsData = json['list_request'] as List<dynamic>;
          final friends = friendsData.map((e) => Friend.fromJson(e)).toList();
          return friends;
        }
        return [];
      };
  @override
  Future<ApiResponse<List<Friend>>> request() {
    return APIProvider().request(this);
  }
}

class GetMutualFriendsAPI
    extends APIRequestRepresentable<List<UserSummaryModel>> {
  final int friendId;
  GetMutualFriendsAPI({required this.friendId});
  @override
  String get endpoint => '/api/friend/get_mutual_friends/$friendId';

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  List<UserSummaryModel> Function(dynamic p1) get fromJson => (json) {
        if (json == null) return [];
        if (json is List) {
          final friends =
              json.map((e) => UserSummaryModel.fromJson(e)).toList();
          return friends;
        }
        return [UserSummaryModel.fromJson(json)];
      };

  @override
  Future<ApiResponse<List<UserSummaryModel>>> request() {
    return APIProvider().request(this);
  }
}

class GetRecommendedFriendsAPI
    extends APIRequestRepresentable<List<SuggestedFriend>> {
  GetRecommendedFriendsAPI();
  @override
  String get endpoint => '/api/friend/get-recommend-friends';

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  List<SuggestedFriend> Function(dynamic p1) get fromJson => (json) {
        if (json == null) return [];
        if (json is List) {
          final friends = json.map((e) => SuggestedFriend.fromJson(e)).toList();
          return friends;
        }
        return [SuggestedFriend.fromJson(json)];
      };

  @override
  Future<ApiResponse<List<SuggestedFriend>>> request() {
    return APIProvider().request(this);
  }
}
