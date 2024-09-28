enum LinkToType {
  comment,
  friend,
  chat,
}

extension StringLinkTo on LinkToType? {
  String? get value {
    switch (this) {
      case LinkToType.comment:
        return 'comment';
      case LinkToType.friend:
        return 'friend_request';
      case LinkToType.chat:
        return 'chat';
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
    case 'chat':
      return LinkToType.chat;
    default:
      return null;
  }
}

String? linkToTypeToJson(LinkToType? type) {
  return type?.value;
}
