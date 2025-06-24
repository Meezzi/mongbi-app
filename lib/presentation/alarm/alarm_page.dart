import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/date_formatter.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/alarm/widgets/alarm_item.dart';
import 'package:mongbi_app/presentation/alarm/widgets/alarm_type.dart';
import 'package:mongbi_app/presentation/alarm/widgets/delete_modal.dart';
import 'package:mongbi_app/providers/alarm_provider.dart';

class AlarmPage extends ConsumerWidget {
  AlarmPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // +1은 마지막 인덱스때 보관 메시지 위젯을 리턴하기 위해 추가한 것
    final alarmList = ref.watch(alarmViewModelProvider);
    final totalLength = (alarmList?.length ?? 0) + 1;

    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Color(0xFFFAFAFA),
        centerTitle: false,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: SvgPicture.asset(
                  'assets/icons/back-arrow.svg',
                  width: 24,
                  height: 24,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 8),
              Expanded(child: Text('알림함', style: Font.title20)),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false, // 배경 터치로 닫히지 않음!
                    barrierColor: Colors.black.withValues(alpha: 0.6),
                    builder: (context) => DeleteModal(),
                  );
                },
                child: SvgPicture.asset(
                  'assets/icons/trash.svg',
                  width: 24,
                  height: 24,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  context.push('/alarm_setting');
                },
                child: SvgPicture.asset(
                  'assets/icons/setting.svg',
                  width: 24,
                  height: 24,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
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
                    final listIndex = index.clamp(0, totalLength - 1 - 1);
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

                      switch (alarm.fcmType) {
                        case 'REMIND':
                          type = '리마인드';
                          break;
                        case 'CHALLENGE':
                          type = '진행 중인 선물';
                          break;
                        case 'REPORT':
                          type = '주간 꿈 리포트';
                          break;
                      }

                      return AlarmItem(
                        type: type,
                        date: DateFormatter.formatYearMonthDay(alarm.fcmSendAt),
                        content: alarm.fcmContent,
                        isRead: alarm.fcmIsRead,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
