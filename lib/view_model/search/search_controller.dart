import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/strings.dart';
import 'package:pic_share/data/enums/user_relationship.dart';
import 'package:pic_share/data/models/user/friend.dart';
import 'package:pic_share/data/models/user/user_friendship_model.dart';
import 'package:pic_share/data/repositories/search/search_repository.dart';
import 'package:pic_share/view_model/friend/friend_controller.dart';

class SearchUserController extends GetxController {
  SearchRepository searchRepository;
  FriendController friendController;
  SearchUserController(
      {required this.searchRepository, required this.friendController}) {
    if (Get.arguments != null) {
      final arguments = Get.arguments as Map<String, dynamic>;

      isSearchWithCode.value = arguments[Strings.isSearchWithUserCode] as bool;
    } else {}
  }
  RxBool isSearchWithCode = false.obs;
  late TextEditingController nameController;
  late TextEditingController codeController;

  RxList<UserFriendShipModel> listSearchUser = RxList<UserFriendShipModel>([]);
  Rx<UserFriendShipModel?> userSearchResult = Rx<UserFriendShipModel?>(null);
  List<Friend> get friends => friendController.friends;
  List<Friend> get sentFriends => friendController.getSentFriends;
  List<Friend> get requestFriends => friendController.requestFriends;
  RxBool isLoading = RxBool(false);
  RxBool isSearch = RxBool(false);
  RxBool isReadyToSearchWithCode = RxBool(false);
  @override
  void onInit() {
    nameController = TextEditingController();
    codeController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    isSearch.value = false;
    nameController.dispose();
    codeController.dispose();
    super.onClose();
  }

  Future<void> onSearchByName(String text) async {
    try {
      listSearchUser.clear();
      isSearch.value = true;
      isLoading.value = true;
      final listUser = await searchRepository.searchByName(name: text);
      if (listUser.isNotEmpty) {
        for (var user in listUser) {
          UserFriendShipModel userFriendShipModel;
          UserRelationship relationship =
              getRelationship(user.id?.toInt() ?? 0);
          userFriendShipModel =
              UserFriendShipModel(relationship: relationship, user: user);
          listSearchUser.add(userFriendShipModel);
        }
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onSearchByCode(String code) async {
    try {
      isSearch.value = true;
      isLoading.value = true;
      final user = await searchRepository.searchByUserCode(code: code);
      if (user != null) {
        UserRelationship relationship = getRelationship(user.id?.toInt() ?? 0);
        userSearchResult.value =
            UserFriendShipModel(relationship: relationship, user: user);
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  void onChangeCode(String code) {
    if (code.isNotEmpty) {
      isReadyToSearchWithCode.value = true;
    } else {
      isReadyToSearchWithCode.value = false;
    }
  }

  UserRelationship getRelationship(int id) {
    for (var friend in friends) {
      if (friend.userId == id || friend.friendId == id) {
        return UserRelationship.friend;
      }
    }
    for (var friend in requestFriends) {
      if (friend.userId == id) {
        return UserRelationship.requested;
      }
    }
    for (var friend in sentFriends) {
      if (friend.friendId == id) {
        return UserRelationship.sent;
      }
    }
    return UserRelationship.notFriend;
  }

  Future<void> onMakeFriendRequest(int id) async {
    try {
      friendController.makeFriendRequest(id);
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }

  Future<void> onRejectFriendRequest(int id) async {
    try {
      friendController.onRejectFriendRequest(id);
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }

  Future<void> onAcceptFriendRequest(int id) async {
    try {
      friendController.onAcceptFriendRequest(id);
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }

  void onItemCLick(int id) {}
  void onChatClick(int id) {}
}
