// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suggested_friend.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SuggestedFriendCWProxy {
  SuggestedFriend score(int score);

  SuggestedFriend user(UserSummaryModel user);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SuggestedFriend(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SuggestedFriend(...).copyWith(id: 12, name: "My name")
  /// ````
  SuggestedFriend call({
    int? score,
    UserSummaryModel? user,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSuggestedFriend.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSuggestedFriend.copyWith.fieldName(...)`
class _$SuggestedFriendCWProxyImpl implements _$SuggestedFriendCWProxy {
  const _$SuggestedFriendCWProxyImpl(this._value);

  final SuggestedFriend _value;

  @override
  SuggestedFriend score(int score) => this(score: score);

  @override
  SuggestedFriend user(UserSummaryModel user) => this(user: user);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SuggestedFriend(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SuggestedFriend(...).copyWith(id: 12, name: "My name")
  /// ````
  SuggestedFriend call({
    Object? score = const $CopyWithPlaceholder(),
    Object? user = const $CopyWithPlaceholder(),
  }) {
    return SuggestedFriend(
      score: score == const $CopyWithPlaceholder() || score == null
          ? _value.score
          // ignore: cast_nullable_to_non_nullable
          : score as int,
      user: user == const $CopyWithPlaceholder() || user == null
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as UserSummaryModel,
    );
  }
}

extension $SuggestedFriendCopyWith on SuggestedFriend {
  /// Returns a callable class that can be used as follows: `instanceOfSuggestedFriend.copyWith(...)` or like so:`instanceOfSuggestedFriend.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SuggestedFriendCWProxy get copyWith => _$SuggestedFriendCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuggestedFriend _$SuggestedFriendFromJson(Map<String, dynamic> json) =>
    SuggestedFriend(
      score: (json['score'] as num).toInt(),
      user: UserSummaryModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SuggestedFriendToJson(SuggestedFriend instance) =>
    <String, dynamic>{
      'score': instance.score,
      'user': instance.user,
    };
