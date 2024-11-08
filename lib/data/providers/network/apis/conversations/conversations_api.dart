import 'package:pic_share/data/enums/message_type.dart';
import 'package:pic_share/data/models/conversation/message.dart';
import 'package:pic_share/data/providers/network/api_provider.dart';
import 'package:pic_share/data/providers/network/api_request_representable.dart';
import 'package:pic_share/data/providers/network/api_response.dart';

class GetConversationsAPI extends APIRequestRepresentable {
  GetConversationsAPI();
  @override
  String get endpoint {
    return '/api/conversations';
  }

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  Function(dynamic json) get fromJson => (json) {
        return json as Map<String, dynamic>;
      };

  @override
  Future<ApiResponse> request() {
    return APIProvider().request(this);
  }
}

class SendMessageAPI extends APIRequestRepresentable {
  final String? urlImage;
  final String text;
  final int? userId;
  final MessageType messageType;
  final int? conversationID;
  SendMessageAPI({
    required this.text,
    required this.messageType,
    this.userId,
    this.urlImage,
    this.conversationID,
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
        'message_type': messageType.value,
        'conversation_id': conversationID,
      };

  @override
  Function(dynamic json) get fromJson => (json) {
        return json as Map<String, dynamic>;
      };
  @override
  Future<ApiResponse> request() {
    return APIProvider().request(this);
  }
}

class GetMessagesAPI extends APIRequestRepresentable<List<Message>> {
  final int id;
  GetMessagesAPI({required this.id});
  @override
  String get endpoint {
    return '/api/conversations/$id/messages';
  }

  @override
  HTTPMethod get method => HTTPMethod.get;

  @override
  List<Message> Function(dynamic p1) get fromJson => (json) {
        if (json == null) return [];
        if (json is List) {
          return json.map((e) => Message.fromJson(e)).toList().cast<Message>();
        }
        return [];
      };

  @override
  Future<ApiResponse<List<Message>>> request() {
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
  Function(dynamic json) get fromJson => (json) {
        return json;
      };
  @override
  Future<ApiResponse> request() {
    return APIProvider().request(this);
  }
}
