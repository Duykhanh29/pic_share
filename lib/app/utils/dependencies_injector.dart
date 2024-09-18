import 'package:get/get.dart';
import 'package:pic_share/data/repositories/auth/auth_repository.dart';
import 'package:pic_share/data/repositories/comments/comment_repository.dart';
import 'package:pic_share/data/repositories/friend/friend_repository.dart';
import 'package:pic_share/data/repositories/notification/notification_repository.dart';
import 'package:pic_share/data/repositories/posts/post_repository.dart';
import 'package:pic_share/data/repositories/search/search_repository.dart';
import 'package:pic_share/data/repositories/user/user_repository.dart';

class DependenciesInjector {
  static Future<void> initDependencies() async {
    Get.put<AuthRepository>(AuthRepositoryImpl(), permanent: true);
    Get.put<UserRepository>(UserRepositoryImpl(), permanent: true);
    Get.put<NotificationRepository>(NotificationRepositoryImpl(),
        permanent: true);
    Get.put<FriendRepository>(FriendRepositoryImpl(), permanent: true);
    Get.put<SearchRepository>(SearchRepositoryImpl(), permanent: true);
    Get.put<PostRepository>(PostRepositoryImpl(), permanent: true);
    Get.put<CommentRepository>(CommentRepositoryImpl(), permanent: true);
  }
}
