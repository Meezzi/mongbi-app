import 'package:mongbi_app/domain/entities/user.dart';

class UserDto {
  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      userIdx: json['USER_IDX'],
      userName: json['USER_NAME'],
      userNickname: json['USER_NICKNAME'],
      userType: json['USER_TYPE'],
      userSocialType: json['USER_SOCIAL_TYPE'],
      userSocialId: json['USER_SOCIAL_ID'],
      userSocialUuid: json['USER_SOCIAL_UUID'],
      userRegDate: DateTime.parse(json['USER_REG_DATE']),
      userLastLoginDate:
          json['USER_LAST_LOGIN_DATE'] != null
              ? DateTime.parse(json['USER_LAST_LOGIN_DATE'])
              : null,
      userIdState: json['USER_ID_STATE'],

      hasAgreedLatestTerms: json['HAS_AGREED_LATEST_TERMS'] ?? false,
    );
  }

  UserDto({
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

    required this.hasAgreedLatestTerms,
  });

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

  final bool hasAgreedLatestTerms;

  User toEntity() {
    return User(
      userIdx: userIdx,
      userName: userName,
      userNickname: userNickname,
      userType: userType,
      userSocialType: userSocialType,
      userSocialId: userSocialId,
      userSocialUuid: userSocialUuid,
      userRegDate: userRegDate,
      userLastLoginDate: userLastLoginDate,
      userIdState: userIdState,
      hasAgreedLatestTerms: hasAgreedLatestTerms,
    );
  }
}
