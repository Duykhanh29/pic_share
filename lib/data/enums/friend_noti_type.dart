enum FriendNotiType {
  requested,
  friend,
}

extension StringFriendNotiType on FriendNotiType? {
  String? get value {
    switch (this) {
      case FriendNotiType.requested:
        return 'requested';
      case FriendNotiType.friend:
        return 'friend';
      default:
        return null;
    }
  }
}

FriendNotiType? friendNotiTypeFromJson(String? value) {
  switch (value) {
    case 'requested':
      return FriendNotiType.requested;
    case 'friend':
      return FriendNotiType.friend;
    default:
      return null;
  }
}

String? friendNotiTypeToJson(FriendNotiType? type) {
  return type?.value;
}
