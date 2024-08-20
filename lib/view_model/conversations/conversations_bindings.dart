import 'package:get/get.dart';
import 'package:pic_share/view_model/conversations/conversations_controller.dart';

class ConversationsBidings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConversationsController>(
      () => ConversationsController(),
    );
  }
}
