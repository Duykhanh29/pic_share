enum NotificationType { user, system }

extension StringNotificationType on NotificationType? {
  String? get value {
    switch (this) {
      case NotificationType.user:
        return 'user';
      case NotificationType.system:
        return 'system';
      default:
        return null;
    }
  }
}

NotificationType? notificationTypeFromJson(String? value) {
  switch (value) {
    case 'user':
      return NotificationType.user;
    case 'system':
      return NotificationType.system;
    default:
      return null;
  }
}

String? notificationTypeToJson(NotificationType? type) {
  return type?.value;
}
