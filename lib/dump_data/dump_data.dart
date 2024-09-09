import 'package:pic_share/data/enums/message_type.dart';
import 'package:pic_share/data/models/conversation/message.dart';
import 'package:pic_share/data/models/comment/comment.dart';
import 'package:pic_share/data/models/comment/comment_user.dart';
import 'package:pic_share/data/models/comment/reply.dart';
import 'package:pic_share/data/models/user/user_summary_model.dart';

MessageContent textContent1 = MessageContent(
  text: "Hello, how are you?",
  urlPath: null,
  height: null,
  width: null,
);

MessageContent textContent2 = MessageContent(
  text: "Let's meet at 5 PM today.",
  urlPath: null,
  height: null,
  width: null,
);

MessageContent imageContent1 = MessageContent(
  text: "null",
  urlPath:
      "https://www.usnews.com/object/image/00000186-7a58-d975-aff7-fffbc8910000/iguazu-falls-stock.jpg?update-time=1677089883729&size=responsive640",
  height: 200.0,
  width: 300.0,
);

MessageContent imageContent2 = MessageContent(
  text: "Check out this cool picture!",
  urlPath:
      "https://as1.ftcdn.net/v2/jpg/01/21/06/48/1000_F_121064813_5CONOqmYSLyCLJlkRn3FsUl8733cg2qc.jpg",
  height: 200.0,
  width: 100.0,
);

MessageContent videoContent1 = MessageContent(
  text: "WHAT DO YOU MEAN?",
  urlPath: "https://example.com/video1.mp4",
  height: 720.0,
  width: 1280.0,
);

MessageContent videoContent2 = MessageContent(
  text: "Watch this amazing video!",
  urlPath: "https://example.com/video2.mp4",
  height: 1080.0,
  width: 1920.0,
);

MessageContent audioContent1 = MessageContent(
  text: "Here's the audio clip you asked for.",
  urlPath: "https://example.com/audio1.mp3",
  height: null,
  width: null,
);

MessageContent fileContent1 = MessageContent(
  text: "Please review the attached document.",
  urlPath: "https://example.com/document.pdf",
  height: null,
  width: null,
);

List<Message> messages = [
  Message(
    id: "msg1",
    sennderId: "user1",
    messageType: MessageType.text,
    messageContent: textContent1,
    time: 1625634832000,
  ),
  Message(
    id: "msg2",
    sennderId: "user2",
    messageType: MessageType.image,
    messageContent: imageContent1,
    time: 1625634892000,
  ),
  Message(
    id: "msg3",
    sennderId: "user1",
    messageType: MessageType.text,
    messageContent: videoContent1,
    time: 1625634952000,
  ),
  Message(
    id: "msg4",
    sennderId: "user3",
    messageType: MessageType.text,
    messageContent: textContent2,
    time: 1625635012000,
  ),
  Message(
    id: "msg5",
    sennderId: "user2",
    messageType: MessageType.image,
    messageContent: imageContent2,
    time: 1625635072000,
  ),
  Message(
    id: "msg6",
    sennderId: "user3",
    messageType: MessageType.text,
    messageContent: videoContent2,
    time: 1625635132000,
  ),
  Message(
    id: "msg7",
    sennderId: "user4",
    messageType: MessageType.text,
    messageContent: audioContent1,
    time: 1625635192000,
  ),
  Message(
    id: "msg8",
    sennderId: "user5",
    messageType: MessageType.text,
    messageContent: fileContent1,
    time: 1625635252000,
  ),
];

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
