class User {
  final int userIdx;
  final String userName;
  final String userNickname;
  final String userType;
  final String userSocialType;
  final String userSocialId;
  final String userSocialUuid;
  final DateTime userRegDate;
  final DateTime? userLastLoginDate;
  final String userIdState;

  User({
    required this.userIdx,
    required this.userName,
    required this.userNickname,
    required this.userType,
    required this.userSocialType,
    required this.userSocialId,
    required this.userSocialUuid,
    required this.userRegDate,
    this.userLastLoginDate,
    required this.userIdState,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
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
    );
  }
}
