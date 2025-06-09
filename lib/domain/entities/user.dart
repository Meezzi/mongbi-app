// domain/entities/user.dart
class User {
  final int userIdx;
  final String userName;
  final String? userNickname;
  final String userType;
  final String userSocialType;
  final String userSocialId;
  final String userSocialUuid;
  final DateTime userRegDate;
  final DateTime? userLastLoginDate;
  final String userIdState;

  const User({
    required this.userIdx,
    required this.userName,
    this.userNickname,
    required this.userType,
    required this.userSocialType,
    required this.userSocialId,
    required this.userSocialUuid,
    required this.userRegDate,
    this.userLastLoginDate,
    required this.userIdState,
  });
}

