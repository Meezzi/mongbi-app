// data/dtos/user_dto.dart
import '../../domain/entities/user.dart';

class UserDto {
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
  });

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
      userLastLoginDate: json['USER_LAST_LOGIN_DATE'] != null
          ? DateTime.parse(json['USER_LAST_LOGIN_DATE'])
          : null,
      userIdState: json['USER_ID_STATE'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'USER_IDX': userIdx,
      'USER_NAME': userName,
      'USER_NICKNAME': userNickname,
      'USER_TYPE': userType,
      'USER_SOCIAL_TYPE': userSocialType,
      'USER_SOCIAL_ID': userSocialId,
      'USER_SOCIAL_UUID': userSocialUuid,
      'USER_REG_DATE': userRegDate.toIso8601String(),
      'USER_LAST_LOGIN_DATE': userLastLoginDate?.toIso8601String(),
      'USER_ID_STATE': userIdState,
    };
  }

  User toEntity() => User(
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
      );
}
