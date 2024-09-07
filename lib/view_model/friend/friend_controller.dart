import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/data/enums/friend_status.dart';
import 'package:pic_share/data/models/user/friend.dart';
import 'package:pic_share/data/repositories/friend/friend_repository.dart';
import 'package:pic_share/routes/app_pages.dart';

class FriendController extends GetxController
    with GetSingleTickerProviderStateMixin, WidgetsBindingObserver {
  FriendRepository friendRepository;

  FriendController({required this.friendRepository});

  late TabController tabController;
  RxBool isFriendShipView = true.obs;
  RxList<Friend> friendList = <Friend>[].obs;
  RxList<Friend> requestedFriends = <Friend>[].obs;
  RxList<Friend> sentFriends = <Friend>[].obs;
  RxBool isLoadingFriends = true.obs;
  RxBool isLoadingFriendRequests = true.obs;

  List<Friend> get friends => friendList;
  List<Friend> get getSentFriends => sentFriends;
  List<Friend> get requestFriends => requestedFriends;
  RxBool isViewInTabbar = true.obs;
  void onChangeView() {
    isFriendShipView.value = !isFriendShipView.value;
  }

  void onNavToPage() {
    isViewInTabbar = false.obs;
  }

  void onResetViewInTabBar() {
    isViewInTabbar = true.obs;
  }

  @override
  void onInit() {
    fetchFriends();
    fetchFriendRequests();
    WidgetsBinding.instance.addObserver(this);
    tabController = TabController(length: 2, vsync: this)..index = 0;
    super.onInit();
  }

  Future<void> onRefresh() async {
    await fetchFriends();
    await fetchFriendRequests();
  }

  Future<void> fetchFriends() async {
    try {
      friendList.value = await friendRepository.getFriendList();
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      isLoadingFriends.value = false;
    }
  }

  Future<void> fetchFriendRequests() async {
    try {
      requestedFriends.value = await friendRepository.getFriendRequestList();
      sentFriends.value = await friendRepository.getFriendRequestSentList();
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      isLoadingFriendRequests.value = false;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // onRefresh();
    super.didChangeAppLifecycleState(state);
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void onItemClick(int id) {}
  Future<void> onRejectFriendRequest(int id) async {
    try {
      await friendRepository.deleteFriend(id);
      updateChangesForFriendRequest(id);
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
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

  void updateChangesForFriendList(Friend friend) {
    Friend updatedFriend = friend.copyWith(status: FriendStatus.friend);
    friendList.add(updatedFriend);
  }

  Future<void> onAcceptFriendRequest(int id) async {
    try {
      await friendRepository.updateFriendStatus(
          id: id, status: FriendStatus.friend);
      updateChangesForFriendList(
          requestedFriends.firstWhere((element) => element.id == id));
      updateChangesForFriendRequest(id);
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }

  Future<void> makeFriendRequest(int id) async {
    try {
      await friendRepository.sendFriendRequest(id);
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    }
  }

  void onNavToChat(int id) {}
  void onNavToSearch() {
    Get.toNamed(Routes.search);
  }
}
