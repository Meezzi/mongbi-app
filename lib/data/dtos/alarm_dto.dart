class AlarmDto {
  AlarmDto({
    this.fcmId,
    this.fcmSendAdminId,
    this.fcmSendFromUserId,
    this.fcmSubject,
    this.fcmContent,
    this.fcmType,
    this.fcmSendAt,
    this.fcmSendState,
    this.fcmIsRead,
  });

  final int? fcmId;
  final int? fcmSendAdminId;
  final int? fcmSendFromUserId;
  final String? fcmSubject;
  final String? fcmContent;
  final String? fcmType;
  final DateTime? fcmSendAt;
  final String? fcmSendState;
  final bool? fcmIsRead;

  factory AlarmDto.fromJson(Map<String, dynamic> json) => AlarmDto(
    fcmId: json['FCM_ID'],
    fcmSendAdminId: json['FCM_SEND_ADMIN_ID'],
    fcmSendFromUserId: json['FCM_SEND_FROM_USER_ID'],
    fcmSubject: json['FCM_SUBJECT'],
    fcmContent: json['FCM_CONTENT'],
    fcmType: json['FCM_TYPE'],
    fcmSendAt:
        json['FCM_SEND_AT'] == null
            ? null
            : DateTime.parse(json['FCM_SEND_AT']),
    fcmSendState: json['FCM_SEND_STATE'],
    fcmIsRead: json['FCM_IS_READ'],
  );

  Map<String, dynamic> toJson() => {
    'FCM_ID': fcmId,
    'FCM_SEND_ADMIN_ID': fcmSendAdminId,
    'FCM_SEND_FROM_USER_ID': fcmSendFromUserId,
    'FCM_SUBJECT': fcmSubject,
    'FCM_CONTENT': fcmContent,
    'FCM_TYPE': fcmType,
    'FCM_SEND_AT': fcmSendAt?.toIso8601String(),
    'FCM_SEND_STATE': fcmSendState,
    'FCM_IS_READ': fcmIsRead,
  };
}
