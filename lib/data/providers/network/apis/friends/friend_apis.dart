import 'package:pic_share/data/enums/friend_status.dart';
import 'package:pic_share/data/providers/network/api_provider.dart';
import 'package:pic_share/data/providers/network/api_request_representable.dart';

class MakeFriendRequestAPI extends APIRequestRepresentable {
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
  Future request() {
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
  Future request() {
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
  Future request() {
    return APIProvider().request(this);
  }
}

class GetListFriendsAPI extends APIRequestRepresentable {
  @override
  String get endpoint => '/api/friend/get_friends';

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  Future request() {
    return APIProvider().request(this);
  }
}

class GetRequestedFriendsAPI extends APIRequestRepresentable {
  @override
  String get endpoint => '/api/friend/get_requested_friends';

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  Future request() {
    return APIProvider().request(this);
  }
}

class GetSentFriendsAPI extends APIRequestRepresentable {
  @override
  String get endpoint => '/api/friend/get_sent_friends';

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  Future request() {
    return APIProvider().request(this);
  }
}
