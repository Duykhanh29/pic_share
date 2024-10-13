import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pic_share/app/constants/strings.dart';
import 'package:pic_share/data/enums/user_relationship.dart';
import 'package:pic_share/data/models/paging.dart';
import 'package:pic_share/data/models/post/post.dart';
import 'package:pic_share/data/models/user/friend.dart';
import 'package:pic_share/data/models/user/user_friendship_model.dart';
import 'package:pic_share/data/models/user/user_log.dart';
import 'package:pic_share/data/models/user/user_summary_model.dart';
import 'package:pic_share/data/repositories/conversations/conversation_repository.dart';
import 'package:pic_share/data/repositories/friend/friend_repository.dart';
import 'package:pic_share/data/repositories/posts/post_repository.dart';
import 'package:pic_share/data/repositories/user/user_repository.dart';
import 'package:pic_share/routes/app_pages.dart';
import 'package:pic_share/view_model/auth/auth_controller.dart';
import 'package:pic_share/view_model/conversations/conversations_controller.dart';
import 'package:pic_share/view_model/friend/friend_controller.dart';

class FriendProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  FriendProfileController({
    required this.friendRepository,
    required this.userRepository,
    required this.postRepository,
    required this.friendController,
  }) {
    if (Get.arguments != null) {
      friend.value = Get.arguments[Strings.userSummary] as UserSummaryModel?;
    }
  }

  FriendRepository friendRepository;
  UserRepository userRepository;
  PostRepository postRepository;
  FriendController friendController;

  late TabController tabController;
  Rx<UserSummaryModel?> friend = Rx<UserSummaryModel?>(null);
  Rx<UserFriendShipModel?> currentFriend = Rx<UserFriendShipModel?>(null);
  Rx<UserLog?> userLog = Rx<UserLog?>(null);
  RxList<UserSummaryModel> mutualFriends = <UserSummaryModel>[].obs;

  RxList<UserFriendShipModel> listMutualFriend =
      RxList<UserFriendShipModel>([]);
  final PagingController<int, Post> pagingController =
      PagingController<int, Post>(
    firstPageKey: 1,
  );
  RxBool isLoading = true.obs;
  RxBool isUserLogLoading = true.obs;
  RxBool isMutualFriendLoading = true.obs;

  // getter
  List<Friend> get friends => friendController.friends;
  List<Friend> get sentFriends => friendController.getSentFriends;
  List<Friend> get requestFriends => friendController.requestFriends;
  @override
  void onInit() async {
    tabController = TabController(length: 2, vsync: this)..index = 0;
    getCurrentFriendRelationship();
    await getMutualFriend();
    await fecthUserLog();
     pagingController.addPageRequestListener((pageKey) async {
      await fetchPosts(page: pageKey);
    });
    await fetchPosts();
    super.onInit();
   
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void getCurrentFriendRelationship() {
    if (friend.value?.id == null) return;
    currentFriend.value = getUserSearchResult(friend.value!);
  }

  Future<void> getMutualFriend() async {
    isMutualFriendLoading.value = true;
    try {
      if (friend.value?.id == null) return;
      mutualFriends.value =
          await friendRepository.getMutualFriends(friend.value!.id!);
      if (mutualFriends.isNotEmpty) {
        for (var user in mutualFriends) {
          UserFriendShipModel userFriendShipModel = getUserSearchResult(user);
          listMutualFriend.add(userFriendShipModel);
        }
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      isMutualFriendLoading.value = false;
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

  Future<void> fecthUserLog() async {
    isUserLogLoading.value = true;
    try {
      if (friend.value?.id == null) return;
      userLog.value = await userRepository.getUserLog(userId: friend.value!.id);
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      isUserLogLoading.value = false;
    }
  }

  Future<void> fetchPosts({int page = 1}) async {
    isLoading.value = true;
    try {
      if (friend.value?.id == null) return;
      Paging<Post> paging = await postRepository.getPostHistory(
          page: page, userId: friend.value!.id);
      final posts = paging.data;
      if (paging.hasMore) {
        pagingController.appendPage(
          posts,
          paging.pageNumber! + 1,
        );
      } else {
        pagingController.appendLastPage(posts);
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  void onClick(int index) async {
    final postId = pagingController.itemList?[index].id;
    await Get.toNamed(Routes.postDetail, arguments: {
      Strings.postId: postId,
    });
  }

  void onMutualFriendClick(int index) async {
    final user = mutualFriends[index];
    await Get.toNamed(Routes.friendProfile, arguments: {
      Strings.userSummary: user,
    });
  }

  Future<void> onAcceptFriendRequest({required int id}) async {
    isLoading.value = true;
    try {
      await friendController.onAcceptFriendRequest(id);
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      onUpdateClick(UserRelationship.friend, id);
      friendController.onRefresh();
      isLoading.value = false;
    }
  }

  Future<void> onMakeFriendRequest(int userId) async {
    isLoading.value = true;
    try {
      Friend? friend = await friendController.makeFriendRequest(userId);
      if (friend != null) {
        onUpdateClick(UserRelationship.sent, friend.id);
        friendController.onRefresh();
      }
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  void onChatClick() {
    if (friend.value == null) return;
    if (!Get.isRegistered<ConversationsController>()) {
      Get.put(
        ConversationsController(
          conversationRepository: Get.find<ConversationRepository>(),
          authController: Get.find<AuthController>(),
        ),
      );
    }
    final conversationController = Get.find<ConversationsController>();
    conversationController.onOpenChatFromSearch(friend.value!);
  }

  Future<void> onRejectFriendRequest({required int id}) async {
    isLoading.value = true;
    try {
      await friendController.onRejectFriendRequest(id);
    } catch (e) {
      debugPrint("Something went wrong: ${e.toString()}");
    } finally {
      onUpdateClick(UserRelationship.notFriend, 0);
      friendController.onRefresh();
      isLoading.value = false;
    }
  }

  void onUpdateClick(UserRelationship relationship, int id) {
    if (currentFriend.value == null) return;
    currentFriend.value = UserFriendShipModel(
        relationship: relationship, user: currentFriend.value!.user, id: id);
  }
}
