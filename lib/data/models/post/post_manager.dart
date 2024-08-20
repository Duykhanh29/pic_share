import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
part 'post_manager.g.dart';

@JsonSerializable()
@CopyWith(copyWithNull: true)
class PostManager {
  final String? id;
  final String? caption;
  final String? image;
  final int? type;
  final int? time;
  PostManager({this.caption, this.id, this.image, this.time, this.type});
  factory PostManager.fromJson(Map<String, dynamic> json) =>
      _$PostManagerFromJson(json);

  Map<String, dynamic> toJson() => _$PostManagerToJson(this);
}
