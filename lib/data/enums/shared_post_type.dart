enum SharedPostType {
  allFriends,
  groupMembers,
}

extension StringSharedPostType on SharedPostType? {
  String? get value {
    switch (this) {
      case SharedPostType.allFriends:
        return 'all_friends';
      case SharedPostType.groupMembers:
        return 'group_member';
      default:
        return null;
    }
  }
}
