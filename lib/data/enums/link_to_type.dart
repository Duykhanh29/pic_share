enum LinkToType {
  comment,
  friend,
}

extension StringLinkTo on LinkToType? {
  String? get value {
    switch (this) {
      case LinkToType.comment:
        return 'comment';
      case LinkToType.friend:
        return 'friend_request';
      default:
        return null;
    }
  }
}

LinkToType? linkToTypeFromJson(String? value) {
  switch (value) {
    case 'comment':
      return LinkToType.comment;
    case 'friend_request':
      return LinkToType.friend;
    default:
      return null;
  }
}

String? linkToTypeToJson(LinkToType? type) {
  return type?.value;
}
