import 'package:pic_share/data/enums/message_type.dart';
import 'package:pic_share/data/models/conversation/conversation_data.dart';
import 'package:pic_share/data/models/conversation/message.dart';
import 'package:flutter/material.dart';
import 'package:pic_share/data/providers/network/apis/conversations/conversations_api.dart';

abstract class ConversationRepository {
  Future<void> sendMessage({
    String? urlImage,
    required String text,
    required int userId,
    required MessageType messageType,
  });
  Future<List<Message>> getMessages(int id);
  Future<void> updateUnreadMsg(int id);
  Future<ConversationData> getConversationData();
}

class ConversationRepositoryImpl implements ConversationRepository {
  @override
  Future<void> sendMessage({
    String? urlImage,
    required String text,
    required int userId,
    required MessageType messageType,
  }) async {
    try {
      final response = await SendMessageAPI(
              messageType: messageType,
              text: text,
              urlImage: urlImage,
              userId: userId)
          .request();
      debugPrint("Message: $response");
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }

  @override
  Future<void> updateUnreadMsg(int id) async {
    try {
      final response = await UpdateMarkAsReadAPI(id: id).request();
      debugPrint("Message: $response");
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }

  @override
  Future<List<Message>> getMessages(int id) async {
    try {
      final response = await GetMessagesAPI(id: id).request();
      final data = response['data'] as List<dynamic>;
      final messages = data.map((e) => Message.fromJson(e)).toList();
      return messages;
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
    return [];
  }

  @override
  Future<ConversationData> getConversationData() async {
    try {
      final response = await GetConversationsAPI().request();
      final data = response['data'] as Map<String, dynamic>;
      final messages = ConversationData.fromJson(data);
      return messages;
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
    return ConversationData();
  }
}
