import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pic_share/data/enums/notification_type.dart';
part 'notification.g.dart';

@JsonSerializable()
@CopyWith(copyWithNull: true)
class Notification {
  final String? id;
  final String? content;
  final bool isSeen;
  final String? senderID;
  final int? createdAt;
  final NotificationType notificationType;
  Notification(
      {this.content,
      this.createdAt,
      this.id,
      this.isSeen = false,
      this.notificationType = NotificationType.user,
      this.senderID});

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}
