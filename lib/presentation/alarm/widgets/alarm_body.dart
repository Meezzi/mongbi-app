import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/date_formatter.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/alarm/widgets/alarm_item.dart';
import 'package:mongbi_app/presentation/alarm/widgets/alarm_type.dart';
import 'package:mongbi_app/providers/alarm_provider.dart';

class AlarmBody extends ConsumerWidget {
  const AlarmBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO : ref.watch를 스플레쉬에서 하기
    // +1은 마지막 인덱스때 보관 메시지 위젯을 리턴하기 위해 추가한 것
    final alarmList = ref.watch(alarmViewModelProvider);
    final alarmVm = ref.watch(alarmViewModelProvider.notifier);
    final totalLength = (alarmList?.length ?? 0) + 1;

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            AlarmType(),
            Expanded(
              child: ListView.builder(
                itemCount: totalLength,
                itemBuilder: (context, index) {
                  // -1은 보관 메시지 때문에 totalLength에 추가한 +1 때문에 한 것
                  // 다른 -1은 알림 리스트의 마지막 인덱스를 구하기 위해 한 것
                  final maxLength = totalLength - 1 - 1;
                  final listIndex = index.clamp(
                    0,
                    maxLength <= 0 ? 0 : maxLength,
                  );
                  final alarm = alarmList?[listIndex];

                  if (totalLength - 1 == index) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          '받은 알림은 30일동안 보관됩니다.',
                          style: Font.subTitle12.copyWith(
                            color: Color(0xFFA6A1AA),
                          ),
                        ),
                      ),
                    );
                  }

                  if (alarm != null) {
                    String type = '';
                    VoidCallback? onTap;

                    switch (alarm.fcmType) {
                      case 'REMIND':
                        type = '리마인드';
                        onTap = () {
                          alarmVm.updateIsReadStatus(alarm.fcmId);
                          context.go('/dream_write');
                        };
                        break;
                      case 'CHALLENGE':
                        type = '진행 중인 선물';
                        onTap = () {
                          alarmVm.updateIsReadStatus(alarm.fcmId);
                          context.go('/home');
                        };
                        break;
                      case 'REPORT':
                        type = '주간 꿈 리포트';
                        onTap = () {
                          alarmVm.updateIsReadStatus(alarm.fcmId);
                          context.go('/history');
                        };
                        break;
                    }

                    return AlarmItem(
                      type: type,
                      date: DateFormatter.formatYearMonthDay(alarm.fcmSendAt),
                      content: alarm.fcmContent,
                      isRead: alarm.fcmIsRead,
                      onTap: onTap,
                    );
                  }

                  return SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
