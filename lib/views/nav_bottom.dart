import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:pic_share/view_model/nav_bottom/nav_bottom_controller.dart';
import 'package:pic_share/views/pages/conversations/conversations_page.dart';
import 'package:pic_share/views/pages/friend/friend_page.dart';
import 'package:pic_share/views/pages/home/home_page.dart';
import 'package:pic_share/views/pages/new_post/new_post_page.dart';
import 'package:badges/badges.dart' as badges;
import 'package:pic_share/views/pages/settings/settings_page.dart';

class NavBottomPage extends GetView<NavBottomController> {
  NavBottomPage({super.key});

  final List<Widget> screens = [
    const HomePage(),
    const FriendPage(),
    const NewPostPage(),
    const ConversationPage(),
    const SettingsPage(),
  ];

  List<PersistentBottomNavBarItem> get _navBarsItems {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        activeColorPrimary: Colors.indigo,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.people_outline_sharp),
        activeColorPrimary: Colors.indigo,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.add_circle_outline),
        activeColorPrimary: Colors.indigo,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
      PersistentBottomNavBarItem(
        icon: buildChatIconWithUnreadCount(),
        activeColorPrimary: Colors.indigo,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person_2_rounded),
        activeColorPrimary: Colors.indigo,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      items: _navBarsItems,
      screens: screens,
      controller: controller.pageController,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardAppears: false,
      animationSettings: const NavBarAnimationSettings(
          // navBarItemAnimation: ItemAnimationSettings(
          //   duration: Duration(milliseconds: 200),
          //   curve: Curves.ease,
          // ),
          // screenTransitionAnimation: ScreenTransitionAnimationSettings(
          //   animateTabTransition: true,
          //   curve: Curves.ease,
          //   duration: Duration(milliseconds: 200),
          // ),
          ),
      navBarStyle: NavBarStyle.style6,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
      onItemSelected: (value) {
        controller.changeNavigationPage(value);
      },
    );
  }

  Widget buildChatIconWithUnreadCount() {
    return Obx(
      () {
        if (controller.chatUnreadCount.value == 0) {
          return _buildChatIcon();
        } else {
          return badges.Badge(
            position: badges.BadgePosition.custom(end: 10),
            badgeContent: Text(
              controller.chatUnreadCount.value.toString(),
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
            child: _buildChatIcon(),
          );
        }
      },
    );
  }

  Widget _buildChatIcon() {
    return const Center(
      child: Icon(
        Icons.chat_bubble_outline_rounded,
      ),
    );
  }
}
