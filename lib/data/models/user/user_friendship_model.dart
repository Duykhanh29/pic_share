import 'package:pic_share/data/enums/user_relationship.dart';
import 'package:pic_share/data/models/user/user_summary_model.dart';

class UserFriendShipModel {
  final UserRelationship relationship;
  final UserSummaryModel user;

  UserFriendShipModel({required this.relationship, required this.user});
}
