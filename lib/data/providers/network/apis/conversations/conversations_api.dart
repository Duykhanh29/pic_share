import 'package:pic_share/data/enums/message_type.dart';
import 'package:pic_share/data/providers/network/api_provider.dart';
import 'package:pic_share/data/providers/network/api_request_representable.dart';

class GetConversationsAPI extends APIRequestRepresentable {
  GetConversationsAPI();
  @override
  String get endpoint {
    return '/api/conversations';
  }

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  Future request() {
    return APIProvider().request(this);
  }
}

class SendMessageAPI extends APIRequestRepresentable {
  final String? urlImage;
  final String text;
  final int userId;
  final MessageType messageType;
  SendMessageAPI({
    required this.text,
    required this.messageType,
    required this.userId,
    this.urlImage,
  });
  @override
  String get endpoint {
    return '/api/conversations/send_message';
  }

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  get body => {
        'url_image': urlImage,
        'text': text,
        'user_id': userId,
        'message_type': messageType.value
      };

  @override
  Future request() {
    return APIProvider().request(this);
  }
}

class GetMessagesAPI extends APIRequestRepresentable {
  final int id;
  GetMessagesAPI({required this.id});
  @override
  String get endpoint {
    return '/api/conversations/$id/messages';
  }

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  Future request() {
    return APIProvider().request(this);
  }
}

class UpdateMarkAsReadAPI extends APIRequestRepresentable {
  final int id;
  UpdateMarkAsReadAPI({required this.id});
  @override
  String get endpoint => '/api/conversations/$id/mark-all-as-read';

  @override
  HTTPMethod get method => HTTPMethod.post;

  @override
  Future request() {
    return APIProvider().request(this);
  }
}
