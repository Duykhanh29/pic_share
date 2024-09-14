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

SharedPostType? sharedPostTypeFromJson(String? value) {
  switch (value) {
    case 'all_friends':
      return SharedPostType.allFriends;
    case 'group_member':
      return SharedPostType.groupMembers;
    default:
      return null;
  }
}

String? sharedPostTypeToJson(SharedPostType? type) {
  return type?.value;
}
