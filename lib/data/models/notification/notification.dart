import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pic_share/data/enums/notification_type.dart';
import 'package:pic_share/data/models/notification/link_to_model.dart';
import 'package:pic_share/data/models/user/user_summary_model.dart';
part 'notification.g.dart';

@JsonSerializable()
@CopyWith(copyWithNull: true)
class Notification {
  final int? id;
  final UserSummaryModel? user;
  final UserSummaryModel? sender;
  final String? content;
  final String? title;
  @JsonKey(name: 'is_seen', fromJson: _fromJsonBool, toJson: _toJsonBool)
  bool isSeen;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @JsonKey(name: 'notification_type')
  @JsonKey(
      name: 'notification_type',
      fromJson: notificationTypeFromJson,
      toJson: notificationTypeToJson)
  final NotificationType notificationType;
  @JsonKey(name: 'link_to')
  final LinkToModel? linkTo;
  @JsonKey(name: 'is_read', fromJson: _fromJsonBool, toJson: _toJsonBool)
  bool isRead;
  Notification({
    this.content,
    this.createdAt,
    this.id,
    this.isSeen = false,
    this.notificationType = NotificationType.user,
    this.user,
    this.linkTo,
    this.sender,
    this.title,
    this.updatedAt,
    this.isRead = false,
  });

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationToJson(this);

  static bool _fromJsonBool(int value) => value == 1;
  static int _toJsonBool(bool value) => value ? 1 : 0;
}
