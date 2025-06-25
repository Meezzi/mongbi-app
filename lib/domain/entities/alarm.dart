class Alarm {
  Alarm({
    required this.fcmId,
    required this.fcmSendFromUserId,
    required this.fcmContent,
    required this.fcmType,
    required this.fcmSendAt,
    required this.fcmIsRead,
  });

  final int fcmId;
  final int fcmSendFromUserId;
  final String fcmContent;
  final String fcmType;
  final DateTime fcmSendAt;
  bool fcmIsRead;

  void updateIsReadStatus() {
    fcmIsRead = true;
  }
}
