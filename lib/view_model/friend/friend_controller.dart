import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/app/constants/strings.dart';
import 'package:pic_share/app/helper/snack_bar_helper.dart';
import 'package:pic_share/data/enums/friend_status.dart';
import 'package:pic_share/data/models/user/friend.dart';
import 'package:pic_share/data/models/user/user_model.dart';
import 'package:pic_share/data/models/user/user_summary_model.dart';
import 'package:pic_share/data/repositories/conversations/conversation_repository.dart';
import 'package:pic_share/data/repositories/friend/friend_repository.dart';
import 'package:pic_share/routes/app_pages.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
import 'package:pic_share/view_model/conversations/conversations_controller.dart';

class FriendController extends GetxController
    with GetSingleTickerProviderStateMixin {
  FriendRepository friendRepository;
  AuthController authController;

  FriendController({
    required this.friendRepository,
    required this.authController,
  });

  late TabController tabController;
  RxBool isFriendShipView = true.obs;
  RxList<Friend> friendList = <Friend>[].obs;
  RxList<Friend> requestedFriends = <Friend>[].obs;
  RxList<Friend> sentFriends = <Friend>[].obs;
  RxBool isLoadingFriends = true.obs;
  RxBool isLoadingFriendRequests = true.obs;
  RxBool isActionLoading = false.obs;

  List<Friend> get friends => friendList;
  List<Friend> get getSentFriends => sentFriends;
  List<Friend> get requestFriends => requestedFriends;
  RxBool isViewInTabbar = true.obs;

// getter
  UserModel? get currentUser => authController.currentUser.value;
  void onChangeView() {
    isFriendShipView.value = !isFriendShipView.value;
  }

  Future<void> onViewInFriendReuquests() async {
    try {
      isFriendShipView.value = false;
      isLoadingFriendRequests.value = true;
      await onRefresh();
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      isLoadingFriendRequests.value = false;
    }
  }

  Future<void> onViewInFriend() async {
    try {
      isFriendShipView.value = true;
      isLoadingFriends.value = true;
      await onRefresh();
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      isLoadingFriends.value = false;
    }
  }

  void onNavToPage() {
    isViewInTabbar = false.obs;
  }

  void onResetViewInTabBar() {
    isViewInTabbar = true.obs;
  }

  @override
  void onInit() async {
    tabController = TabController(length: 2, vsync: this)..index = 0;
    ever(authController.currentUser, (UserModel? user) async {
      if (user != null) {
        await fetchFriends();
        await fetchFriendRequests();
      } else {
        friendList.value = [];
        requestedFriends.value = [];
        sentFriends.value = [];
      }
    });
    await fetchFriends();
    await fetchFriendRequests();
    super.onInit();
  }

  Future<void> onRefresh() async {
    if (isFriendShipView.value) {
      await fetchFriends();
    } else {
      await fetchFriendRequests();
    }
  }

  Future<void> fetchFriends() async {
    try {
      final response = await friendRepository.getFriendList();
      if (response.isSuccess) {
        friendList.value = response.data ?? [];
      } else {
        SnackbarHelper.errorSnackbar(response.message ?? '');
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      isLoadingFriends.value = false;
    }
  }

  Future<void> fetchFriendRequests() async {
    try {
      final requestedResponse = await friendRepository.getFriendRequestList();
      if (requestedResponse.isSuccess) {
        final requestedList = requestedResponse.data ?? [];

        requestedFriends.value = requestedList.reversed.toList();
      } else {
        SnackbarHelper.errorSnackbar(requestedResponse.message ?? '');
      }
      // sent requests
      final sentResponse = await friendRepository.getFriendRequestSentList();
      if (sentResponse.isSuccess) {
        final sentList = sentResponse.data ?? [];
        sentFriends.value = sentList.reversed.toList();
      } else {
        SnackbarHelper.errorSnackbar(sentResponse.message ?? '');
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      isLoadingFriendRequests.value = false;
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void onItemClick(int id) {
    final currentFriendList = isFriendShipView.value
        ? friendList
        : (tabController.index == 0 ? requestedFriends : sentFriends);
    UserSummaryModel? selectedUser = getSelectedUser(id, currentFriendList);
    if (selectedUser != null) {
      Get.toNamed(Routes.friendProfile, arguments: {
        Strings.userSummary: selectedUser,
      });
    }
  }

  Future<void> onRejectFriendRequest(int id) async {
    isActionLoading.value = true;
    try {
      // just for improvinf loading time
      updateChangesForFriendRequest(id);
      updateChangesForFriends(id);
      isActionLoading.value = false;
      //
      final response = await friendRepository.deleteFriend(id);
      if (response.isSuccess) {
        // updateChangesForFriendRequest(id);
        // updateChangesForFriends(id);
      } else {
        SnackbarHelper.errorSnackbar(response.message ?? '');
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      isActionLoading.value = false;
    }
  }

  void updateChangesForFriendRequest(int id) {
    bool flag = false;
    for (var i = 0; i < requestedFriends.length; i++) {
      if (requestedFriends[i].id == id) {
        requestedFriends.removeAt(i);
        flag = true;
        break;
      }
    }
    if (!flag) {
      for (var i = 0; i < sentFriends.length; i++) {
        if (sentFriends[i].id == id) {
          sentFriends.removeAt(i);
          break;
        }
      }
    }
  }

  void updateChangesForFriends(int id) {
    bool flag = false;
    for (var i = 0; i < friendList.length; i++) {
      if (friendList[i].id == id) {
        friendList.removeAt(i);
        flag = true;
        break;
      }
    }
    if (!flag) {
      for (var i = 0; i < friendList.length; i++) {
        if (friendList[i].id == id) {
          friendList.removeAt(i);
          break;
        }
      }
    }
  }

  void updateChangesForFriendList(Friend friend) {
    Friend updatedFriend = friend.copyWith(status: FriendStatus.friend);
    friendList.add(updatedFriend);
  }

  Future<void> onAcceptFriendRequest(int id) async {
    isActionLoading.value = true;
    try {
      // just for improving loading time
      updateChangesForFriendList(
          requestedFriends.firstWhere((element) => element.id == id));
      updateChangesForFriendRequest(id);
      isActionLoading.value = false;
      //
      final response = await friendRepository.updateFriendStatus(
          id: id, status: FriendStatus.friend);
      if (response.isSuccess) {
        // updateChangesForFriendList(
        //     requestedFriends.firstWhere((element) => element.id == id));
        // updateChangesForFriendRequest(id);
      } else {
        SnackbarHelper.errorSnackbar(response.message ?? '');
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      isActionLoading.value = false;
    }
  }

  Future<Friend?> makeFriendRequest(int id) async {
    try {
      final response = await friendRepository.sendFriendRequest(id);
      if (response.isSuccess) {
        return response.data;
      } else {
        SnackbarHelper.errorSnackbar(response.message ?? '');
        return null;
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
    return null;
  }

  void onNavToChat(int id) {
    final index = friendList.indexWhere((user) => user.id == id);
    if (index != -1) {
      final friend = friendList[index];
      UserSummaryModel userSummaryModel = getSelectedUserWithFriend(friend);
      if (!Get.isRegistered<ConversationsController>()) {
        Get.put(
          ConversationsController(
            conversationRepository: Get.find<ConversationRepository>(),
            authController: Get.find<AuthController>(),
          ),
        );
      }
      final conversationController = Get.find<ConversationsController>();
      conversationController.onOpenChatFromSearch(userSummaryModel);
    }
  }

  void onNavToSearch() {
    Get.toNamed(Routes.search);
  }

  // helper
  UserSummaryModel? getSelectedUser(int userId, List<Friend> friends) {
    final index = friends.indexWhere((user) => user.id == userId);
    if (index != -1) {
      final friend = friends[index];
      return getSelectedUserWithFriend(friend);
    }
    return null;
  }

  UserSummaryModel getSelectedUserWithFriend(Friend friend) {
    return UserSummaryModel(
      id: currentUser?.id == friend.friendId ? friend.userId : friend.friendId,
      name: friend.name,
      urlAvatar: friend.avatar,
    );
  }
}
