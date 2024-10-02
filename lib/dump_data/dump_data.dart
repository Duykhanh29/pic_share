import 'package:pic_share/data/models/comment/comment.dart';
import 'package:pic_share/data/models/comment/comment_user.dart';
import 'package:pic_share/data/models/comment/reply.dart';
import 'package:pic_share/data/models/user/user_summary_model.dart';

final mockUser1 = CommentUser(
  userName: "John Doe",
  uid: "user123",
  urlAvatar:
      "https://cdn.pixabay.com/photo/2023/12/05/08/14/woman-8431035_1280.jpg",
);

final mockUser2 = CommentUser(
  userName: "Jane Smith",
  uid: "user456",
  urlAvatar:
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWFTlLbnUtKivhY5n0oe-RFFutJTt8tOeLwT2nfqHyBC9tEiP1jBDwRwV6evK9eJY7Sso&usqp=CAU",
);

final mockUser3 = CommentUser(
  userName: "Alice Johnson",
  uid: "user789",
  urlAvatar:
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRU91_mCTiZ96xE7IFYmV7DkIFK5bPbgN46sFYMQNd_WBAS8Ma1m2SCbis5WAyR_un7vPQ&usqp=CAU",
);

// Mock data for Reply
final mockReply1 = Reply(
  id: 1,
  content: "This is a reply to your comment.",
  createdAt: DateTime.now().toIso8601String(),
  user: UserSummaryModel(id: 1, name: "fa"),
);

final mockReply2 = Reply(
  id: 1,
  content: "This is a reply to your comment.",
  createdAt: DateTime.now().toIso8601String(),
  user: UserSummaryModel(id: 1, name: "fa"),
);

final mockReply3 = Reply(
  id: 1,
  content: "This is a reply to your comment.",
  createdAt: DateTime.now().toIso8601String(),
  user: UserSummaryModel(id: 1, name: "fa"),
);

final mockReply4 = Reply(
  id: 1,
  content: "This is a reply to your comment.",
  createdAt: DateTime.now().toIso8601String(),
  user: UserSummaryModel(id: 1, name: "fa"),
);

// Mock data for Comment
final mockComment = Comment(
  id: 1,
  content: "This is a reply to your comment.",
  createdAt: DateTime.now().toIso8601String(),
  listReply: [mockReply1, mockReply2, mockReply3, mockReply4],
  user: UserSummaryModel(id: 1, name: "fa"),
);
