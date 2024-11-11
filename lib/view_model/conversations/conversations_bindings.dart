import 'package:get/get.dart';
import 'package:pic_share/data/repositories/conversations/conversation_repository.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
import 'package:pic_share/view_model/conversations/conversations_controller.dart';

class ConversationsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConversationsController>(
      () => ConversationsController(
        conversationRepository: Get.find<ConversationRepository>(),
        authController: Get.find<AuthController>(),
      ),
    );
  }
}
