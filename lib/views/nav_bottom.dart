import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:pic_share/view_model/nav_bottom/nav_bottom_controller.dart';
import 'package:pic_share/views/pages/conversations/conversations_page.dart';
import 'package:pic_share/views/pages/home/home_page.dart';
import 'package:pic_share/views/pages/new_post/new_post_page.dart';
import 'package:pic_share/views/pages/notification/notification_page.dart';
import 'package:badges/badges.dart' as badges;
import 'package:pic_share/views/pages/settings/settings_page.dart';

class NavBottomPage extends GetView<NavBottomController> {
  NavBottomPage({super.key});

  final List<Widget> screens = [
    const HomePage(),
    const NotificationPage(),
    const NewPostPage(),
    const ConversationPage(),
    const SettinngsPage(),
  ];
  final List<PersistentBottomNavBarItem> _navBarsItems = [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home),
      activeColorPrimary: Colors.indigo,
      inactiveColorPrimary: Colors.grey,
      inactiveColorSecondary: Colors.purple,
    ),
    PersistentBottomNavBarItem(
      icon: badges.Badge(
        position: badges.BadgePosition.custom(end: 10),
        badgeContent: Text(
          "2",
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
        child: Center(
          child: const Icon(
            Icons.notifications,
          ),
        ),
      ),
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
      icon: const Icon(Icons.message),
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
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      items: _navBarsItems,
      screens: screens,
      controller: controller.pageController,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: false,
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
}
