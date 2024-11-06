import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/strings.dart';
import 'package:pic_share/app/helper/snack_bar_helper.dart';
import 'package:pic_share/data/enums/user_relationship.dart';
import 'package:pic_share/data/models/user/friend.dart';
import 'package:pic_share/data/models/user/user_friendship_model.dart';
import 'package:pic_share/data/models/user/user_summary_model.dart';
import 'package:pic_share/data/repositories/conversations/conversation_repository.dart';
import 'package:pic_share/data/repositories/search/search_repository.dart';
import 'package:pic_share/routes/app_pages.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
import 'package:pic_share/view_model/conversations/conversations_controller.dart';
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
  void onInit() async {
    nameController = TextEditingController();
    codeController = TextEditingController();
    if (isSearchWithCode.value) {
      await friendController.onRefresh();
    }
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
          UserFriendShipModel userFriendShipModel = getUserSearchResult(user);
          // UserRelationship relationship =
          //     getRelationship(user.id?.toInt() ?? 0);
          // userFriendShipModel =
          //     UserFriendShipModel(relationship: relationship, user: user);
          listSearchUser.add(userFriendShipModel);
        }
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
      SnackbarHelper.errorSnackbar(e.toString());
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
        userSearchResult.value = getUserSearchResult(user);
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
      SnackbarHelper.errorSnackbar(e.toString());
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

  UserFriendShipModel getUserSearchResult(UserSummaryModel user) {
    UserRelationship userRelationship = UserRelationship.notFriend;
    int id = 0;
    for (var friend in friends) {
      if (friend.userId == user.id || friend.friendId == user.id) {
        userRelationship = UserRelationship.friend;
        id = friend.id;
        return UserFriendShipModel(
            relationship: userRelationship, user: user, id: id);
      }
    }
    for (var friend in requestFriends) {
      if (friend.userId == user.id) {
        userRelationship = UserRelationship.requested;
        id = friend.id;
        return UserFriendShipModel(
            relationship: userRelationship, user: user, id: id);
      }
    }
    for (var friend in sentFriends) {
      if (friend.friendId == user.id) {
        userRelationship = UserRelationship.sent;
        id = friend.id;
        return UserFriendShipModel(
            relationship: userRelationship, user: user, id: id);
      }
    }
    return UserFriendShipModel(
        relationship: userRelationship, user: user, id: id);
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
    isLoading.value = true;
    try {
      Friend? friend = await friendController.makeFriendRequest(id);
      if (friend != null) {
        onUpdateClick(UserRelationship.sent, id, friend.id);
        friendController.onRefresh();
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onRejectFriendRequest(
      {required int userID, required int id}) async {
    isLoading.value = true;
    try {
      // just for improving loading time
      onUpdateClick(UserRelationship.notFriend, userID, id);
      isLoading.value = false;
      //
      await friendController.onRejectFriendRequest(id);
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      // onUpdateClick(UserRelationship.notFriend, userID, 0);
      friendController.onRefresh();
      isLoading.value = false;
    }
  }

  Future<void> onAcceptFriendRequest(
      {required int userID, required int id}) async {
    isLoading.value = true;
    try {
      // just for improving loading time
      onUpdateClick(UserRelationship.friend, userID, id);
      isLoading.value = false;
      //
      await friendController.onAcceptFriendRequest(id);
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      // onUpdateClick(UserRelationship.friend, userID, id);
      friendController.onRefresh();
      isLoading.value = false;
    }
  }

  void onUpdateClick(UserRelationship relationship, int userID, int id) {
    if (isSearchWithCode.value) {
      userSearchResult.value = UserFriendShipModel(
          relationship: relationship,
          user: userSearchResult.value!.user,
          id: id);
    } else {
      for (var i = 0; i < listSearchUser.length; i++) {
        if (userID == listSearchUser[i].user.id) {
          listSearchUser[i] = UserFriendShipModel(
              relationship: relationship, user: listSearchUser[i].user, id: id);
          break;
        }
      }
    }
  }

  void onItemCLick(int id) {
    UserFriendShipModel? searchedUser;
    if (isSearchWithCode.value) {
      searchedUser = userSearchResult.value;
    } else {
      final index = listSearchUser.indexWhere((user) => user.user.id == id);
      if (index != -1) {
        searchedUser = listSearchUser[index];
      }
    }
    if (searchedUser != null) {
      Get.toNamed(Routes.friendProfile, arguments: {
        Strings.userSummary: searchedUser.user,
      });
    }
  }

  void onChatClick(int id) {
    UserFriendShipModel? searchedUser;
    if (isSearchWithCode.value) {
      searchedUser = userSearchResult.value;
    } else {
      final index = listSearchUser.indexWhere((user) => user.user.id == id);
      if (index != -1) {
        searchedUser = listSearchUser[index];
      }
    }
    if (searchedUser != null) {
      final user = searchedUser.user;
      if (!Get.isRegistered<ConversationsController>()) {
        Get.put(
          ConversationsController(
            conversationRepository: Get.find<ConversationRepository>(),
            authController: Get.find<AuthController>(),
          ),
        );
      }
      final conversationController = Get.find<ConversationsController>();
      conversationController.onOpenChatFromSearch(user);
    }
  }
}
