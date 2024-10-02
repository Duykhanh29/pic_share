import 'package:get/get.dart';
import 'package:pic_share/data/repositories/conversations/conversation_repository.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
import 'package:pic_share/view_model/chat/chat_controller.dart';

class ChatBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(
      () => ChatController(
        conversationRepository: Get.find<ConversationRepository>(),
        authController: Get.find<AuthController>(),
      ),
    );
  }
}
