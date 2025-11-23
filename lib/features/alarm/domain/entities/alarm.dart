import 'package:freezed_annotation/freezed_annotation.dart';

part 'alarm.freezed.dart';

@freezed
abstract class Alarm with _$Alarm {
  const factory Alarm({
    @Default(0) int fcmId,
    @Default(0) int fcmSendFromUserId,
    @Default('') String fcmContent,
    @Default('') String fcmType,
    required DateTime fcmSendAt,
    @Default(false) bool fcmIsRead,
  }) = _Alarm;
}
