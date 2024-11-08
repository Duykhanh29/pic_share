import 'package:pic_share/data/enums/message_type.dart';
import 'package:pic_share/data/models/conversation/conversation_data.dart';
import 'package:pic_share/data/models/conversation/message.dart';
import 'package:flutter/material.dart';
import 'package:pic_share/data/providers/network/api_response.dart';
import 'package:pic_share/data/providers/network/apis/conversations/conversations_api.dart';

abstract class ConversationRepository {
  Future<ApiResponse> sendMessage({
    String? urlImage,
    required String text,
    required MessageType messageType,
    int? userId,
    int? conversationId,
  });
  Future<ApiResponse<List<Message>>> getMessages(int id);
  Future<ApiResponse> updateUnreadMsg(int id);
  Future<ConversationData> getConversationData();
}

class ConversationRepositoryImpl implements ConversationRepository {
  @override
  Future<ApiResponse> sendMessage({
    String? urlImage,
    required String text,
    required MessageType messageType,
    int? userId,
    int? conversationId,
  }) async {
    final response = await SendMessageAPI(
      messageType: messageType,
      text: text,
      urlImage: urlImage,
      userId: userId,
      conversationID: conversationId,
    ).request();
    return response;
  }

  @override
  Future<ApiResponse> updateUnreadMsg(int id) async {
    final response = await UpdateMarkAsReadAPI(id: id).request();
    return response;
  }

  @override
  Future<ApiResponse<List<Message>>> getMessages(int id) async {
    final response = await GetMessagesAPI(id: id).request();
    return response;
  }

  @override
  Future<ConversationData> getConversationData() async {
    try {
      final response = await GetConversationsAPI().request();
      final data = response.data as Map<String, dynamic>;
      final messages = ConversationData.fromJson(data);
      return messages;
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
    return ConversationData();
  }
}
