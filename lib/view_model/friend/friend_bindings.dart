import 'package:get/get.dart';
import 'package:pic_share/data/repositories/friend/friend_repository.dart';
import 'package:pic_share/view_model/friend/friend_controller.dart';

class FriendBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FriendController>(
      () => FriendController(
        friendRepository: Get.find<FriendRepository>(),
      ),
    );
  }
}
