enum MessageType {
  text,
  image,
}

extension StringMessageType on MessageType? {
  String? get value {
    switch (this) {
      case MessageType.text:
        return 'text';
      case MessageType.image:
        return 'image';
      default:
        return null;
    }
  }
}

MessageType? messageTypeFromJson(String? value) {
  switch (value) {
    case 'text':
      return MessageType.text;
    case 'image':
      return MessageType.image;
    default:
      return null;
  }
}

String? messageTypeToJson(MessageType? type) {
  return type?.value;
}
