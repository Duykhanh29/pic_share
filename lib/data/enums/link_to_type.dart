enum LinkToType {
  comment,
  friend,
  chat,
  deletion,
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
      case LinkToType.deletion:
        return 'deletion';
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
    case 'deletion':
      return LinkToType.deletion;
    default:
      return null;
  }
}

String? linkToTypeToJson(LinkToType? type) {
  return type?.value;
}
