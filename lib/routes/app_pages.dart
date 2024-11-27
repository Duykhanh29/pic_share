import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pic_share/view_model/change_password/change_pass_bindings.dart';
import 'package:pic_share/view_model/chat/chat_bindings.dart';
import 'package:pic_share/view_model/comments/comments_bindings.dart';
import 'package:pic_share/view_model/conversations/conversations_bindings.dart';
import 'package:pic_share/view_model/deleted_post/deleted_post_bindings.dart';
import 'package:pic_share/view_model/edit_profile/edit_profile_bindings.dart';
import 'package:pic_share/view_model/friend/friend_bindings.dart';
import 'package:pic_share/view_model/friend_profile/friend_profile_bindings.dart';
import 'package:pic_share/view_model/home/home_bidings.dart';
import 'package:pic_share/view_model/language/language_bindings.dart';
import 'package:pic_share/view_model/nav_bottom/nav_bottom_bidings.dart';
import 'package:pic_share/view_model/new_post/new_post_biding.dart';
import 'package:pic_share/view_model/notifications/notification_bindings.dart';
import 'package:pic_share/view_model/post_detail/post_detail_bindings.dart';
import 'package:pic_share/view_model/post_history/post_history_bindings.dart';
import 'package:pic_share/view_model/posts_location/posts_location_bindings.dart';
import 'package:pic_share/view_model/posts_with_location/posts_with_location_binding.dart';
import 'package:pic_share/view_model/profile/profile_bindings.dart';
import 'package:pic_share/view_model/reacted_users/reacted_users_bindings.dart';
import 'package:pic_share/view_model/register/register_bindings.dart';
import 'package:pic_share/view_model/search/search_bindings.dart';
import 'package:pic_share/view_model/settings/setting_bindings.dart';
import 'package:pic_share/view_model/sign_in/sign_in_bindings.dart';
import 'package:pic_share/view_model/verify/verify_bindings.dart';
import 'package:pic_share/views/nav_bottom.dart';
import 'package:pic_share/views/pages/amdin_view/admin_page.dart';
import 'package:pic_share/views/pages/auth/check_2fa_page.dart';
import 'package:pic_share/views/pages/auth/forgot_password_page.dart';
import 'package:pic_share/views/pages/auth/reset_password_page.dart';
import 'package:pic_share/views/pages/change_pass/change_pass_page.dart';
import 'package:pic_share/views/pages/chat/chat_page.dart';
import 'package:pic_share/views/pages/comments/comments_page.dart';
import 'package:pic_share/views/pages/conversations/conversations_page.dart';
import 'package:pic_share/views/pages/deleted_post/deleted_post_page.dart';
import 'package:pic_share/views/pages/edit_profile/edit_profile_page.dart';
import 'package:pic_share/views/pages/friend/friend_page.dart';
import 'package:pic_share/views/pages/friend_profile/friend_profile_page.dart';
import 'package:pic_share/views/pages/grid_posts_view/grid_posts_page.dart';
import 'package:pic_share/views/pages/home/home_page.dart';
import 'package:pic_share/views/pages/languages/language_page.dart';
import 'package:pic_share/views/pages/new_post/new_post_page.dart';
import 'package:pic_share/views/pages/not_found/not_found_page.dart';
import 'package:pic_share/views/pages/notification/notification_page.dart';
import 'package:pic_share/views/pages/post_detail/post_detail_page.dart';
import 'package:pic_share/views/pages/post_histories/post_history_page.dart';
import 'package:pic_share/views/pages/posts_location/posts_location_page.dart';
import 'package:pic_share/views/pages/posts_with_location/posts_with_location_page.dart';
import 'package:pic_share/views/pages/profile/profile_page.dart';
import 'package:pic_share/views/pages/reacted_users/reacted_users_page.dart';
import 'package:pic_share/views/pages/register/register_page.dart';
import 'package:pic_share/views/pages/search/search_page.dart';
import 'package:pic_share/views/pages/security/security_page.dart';
import 'package:pic_share/views/pages/settings/notification_settings_page.dart';
import 'package:pic_share/views/pages/settings/settings_page.dart';
import 'package:pic_share/views/pages/sign_in/sign_in_page.dart';
import 'package:pic_share/views/pages/verify/verify_page.dart';
import 'package:pic_share/views/widgets/no_connection_view.dart';

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
      binding: NavBottomBindings(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: Routes.conversation,
      page: () => const ConversationPage(),
      binding: ConversationsBindings(),
    ),
    GetPage(
      name: Routes.newPost,
      page: () => const NewPostPage(),
      binding: NewPostBindings(),
    ),
    GetPage(
      name: Routes.notification,
      page: () => const NotificationPage(),
      binding: NotificationBindings(),
    ),
    GetPage(
      name: Routes.settings,
      page: () => const SettingsPage(),
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
      page: () => const CommentsPage(),
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
    ),
    GetPage(
      name: Routes.profile,
      page: () => const ProfilePage(),
      binding: ProfileBindings(),
    ),
    GetPage(
      name: Routes.changePassword,
      page: () => const ChangePasswordPage(),
      binding: ChangePasswordBindings(),
    ),
    GetPage(
      name: Routes.verifyPage,
      page: () => const VerifyPage(),
      binding: VerifyBindings(),
    ),
    GetPage(
      name: Routes.editProfile,
      page: () => const EditProfilePage(),
      binding: EditProfileBindings(),
    ),
    GetPage(
      name: Routes.friend,
      page: () => const FriendPage(),
      binding: FriendBinding(),
    ),
    GetPage(
      name: Routes.search,
      page: () => const SearchPage(),
      binding: SearchBindings(),
    ),
    GetPage(
      name: Routes.security,
      page: () => const SecurityPage(),
    ),
    GetPage(
      name: Routes.notificationSettings,
      page: () => const NotificationSettingsPage(),
      binding: SettingsBindings(),
    ),
    GetPage(
      name: Routes.postHistory,
      page: () => const PostHistoryPage(),
      binding: PostHistoryBindings(),
    ),
    GetPage(
      name: Routes.postDetail,
      page: () => const PostDetailPage(),
      binding: PostDetailBindings(),
    ),
    GetPage(
      name: Routes.postsWithLocation,
      page: () => const PostsWithLocationPage(),
      binding: PostsWithLocationBindings(),
    ),
    GetPage(
      name: Routes.postsLocation,
      page: () => const PostsLocationPage(),
      binding: PostsLocationBinding(),
    ),
    GetPage(
      name: Routes.friendProfile,
      page: () => const FriendProfilePage(),
      binding: FriendProfileBinding(),
    ),
    GetPage(
      name: Routes.adminPage,
      page: () => const AdminPage(),
    ),
    GetPage(
      name: Routes.deletedPost,
      page: () => const DeletedPostPage(),
      binding: DeletedPostBindings(),
    ),
    GetPage(
      name: Routes.notFound,
      page: () => const NotFoundPage(),
    ),
    GetPage(
      name: Routes.check2Fa,
      page: () => const Check2FPage(),
    ),
    GetPage(
      name: Routes.noConnection,
      page: () => const NoConnectionView(),
    ),
    GetPage(
      name: Routes.forgotPassword,
      page: () => const ForgotPasswordPage(),
    ),
    GetPage(
      name: Routes.resetPassword,
      page: () => const ResetPasswordPage(),
    ),
  ];
}
