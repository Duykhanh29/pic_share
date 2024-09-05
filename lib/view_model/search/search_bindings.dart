import 'package:get/get.dart';
import 'package:pic_share/data/repositories/search/search_repository.dart';
import 'package:pic_share/view_model/friend/friend_controller.dart';
import 'package:pic_share/view_model/search/search_controller.dart';

class SearchBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchUserController>(
      () => SearchUserController(
        searchRepository: Get.find<SearchRepository>(),
        friendController: Get.find<FriendController>(),
      ),
    );
  }
}
