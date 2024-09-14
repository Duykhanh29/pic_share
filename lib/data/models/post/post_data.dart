import 'package:pic_share/data/models/post/post_detail.dart';

class PostData {
  final PostDetail post;
  bool isLike;

  PostData({required this.post, this.isLike = false});

  PostData copyWith({
    PostDetail? post,
    bool? isLike,
  }) {
    return PostData(
      post: post ?? this.post,
      isLike: isLike ?? this.isLike,
    );
  }
}
