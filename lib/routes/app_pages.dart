import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/view_model/chat/chat_bindings.dart';
import 'package:pic_share/view_model/comments/comments_bindings.dart';
import 'package:pic_share/view_model/conversations/conversations_bindings.dart';
import 'package:pic_share/view_model/home/home_bidings.dart';
import 'package:pic_share/view_model/language/language_bindings.dart';
import 'package:pic_share/view_model/nav_bottom/nav_bottom_bidings.dart';
import 'package:pic_share/view_model/new_post/new_post_biding.dart';
import 'package:pic_share/view_model/notifications/notification_bindings.dart';
import 'package:pic_share/view_model/reacted_users/reacted_users_bindings.dart';
import 'package:pic_share/view_model/register/register_bindings.dart';
import 'package:pic_share/view_model/settings/setting_bindings.dart';
import 'package:pic_share/view_model/sign_in/sign_in_bindings.dart';
import 'package:pic_share/views/nav_bottom.dart';
import 'package:pic_share/views/pages/chat/chat_page.dart';
import 'package:pic_share/views/pages/comments/comments_page.dart';
import 'package:pic_share/views/pages/conversations/conversations_page.dart';
import 'package:pic_share/views/pages/grid_posts_view/grid_posts_page.dart';
import 'package:pic_share/views/pages/home/home_page.dart';
import 'package:pic_share/views/pages/languages/language_page.dart';
import 'package:pic_share/views/pages/new_post/new_post_page.dart';
import 'package:pic_share/views/pages/notification/notification_page.dart';
import 'package:pic_share/views/pages/reacted_users/reacted_users_page.dart';
import 'package:pic_share/views/pages/register/register_page.dart';
import 'package:pic_share/views/pages/settings/settings_page.dart';
import 'package:pic_share/views/pages/sign_in/sign_in_page.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.root,
      page: () => Container(),
    ),
    GetPage(
      name: Routes.navBar,
      page: () => NavBottomPage(),
      binding: NavBottomBindinngs(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: Routes.conversation,
      page: () => const ConversationPage(),
      binding: ConversationsBidings(),
    ),
    GetPage(
      name: Routes.newPost,
      page: () => const NewPostPage(),
      binding: NewPostBidings(),
    ),
    GetPage(
      name: Routes.notification,
      page: () => const NotificationPage(),
      binding: NotificationBindings(),
    ),
    GetPage(
      name: Routes.settings,
      page: () => const SettinngsPage(),
    ),
    GetPage(
      name: Routes.gridPostView,
      page: () => const GridPostPage(),
      binding: SettingsBindings(),
    ),
    GetPage(
      name: Routes.language,
      page: () => const LanguagePage(),
      binding: LanguageBindings(),
    ),
    GetPage(
      name: Routes.comments,
      page: () => CommentsPage(),
      binding: CommentsBindings(),
    ),
    GetPage(
      name: Routes.reactedUsers,
      page: () => const ReactedUsersPage(),
      binding: ReactedUsersBindings(),
    ),
    GetPage(
      name: Routes.chat,
      page: () => const ChatPage(),
      binding: ChatBindings(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const SignInPage(),
      binding: SignInBindings(),
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterPage(),
      binding: RegisterBindings(),
    )
  ];
}
