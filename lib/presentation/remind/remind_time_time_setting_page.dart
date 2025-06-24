import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/common/button_type.dart';
import 'package:mongbi_app/presentation/common/filled_button_widget.dart';
import 'package:mongbi_app/presentation/remind/view_model/remind_time_setting_view_model.dart';
import 'package:mongbi_app/presentation/remind/widgets/remind_time_setting_text_widget.dart';
import 'package:mongbi_app/presentation/remind/widgets/remind_time_setting_widget.dart';
import 'package:mongbi_app/presentation/remind/widgets/remoind_time_time_setting_button.widget.dart';
import 'package:permission_handler/permission_handler.dart';

class RemindTimePickerPage extends StatefulWidget {
  const RemindTimePickerPage({super.key});

  @override
  State<RemindTimePickerPage> createState() => _RemindTimePickerPageState();
}

class _RemindTimePickerPageState extends State<RemindTimePickerPage> {
  TimeOfDay selectedTime = const TimeOfDay(hour: 8, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24, top: 16),
          child: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/back-arrow.svg',
              width: 24,
              height: 24,
            ),
            onPressed: () => Navigator.pop(context),
            iconSize:24, // 이건 실제론 무시되지만 명시해주면 의도 파악에 도움
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(), // 내부 공간 제약 제거
            splashRadius: 20,
          ),
        ),
        toolbarHeight: 56,
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 72),
                  const OnboardingText(
                    text: '몽비와 함께할 시간을 알려줘!',
                    type: RemindTimeSettingTextType.title,
                  ),
                  const SizedBox(height: 8),
                  const OnboardingText(
                    text: '원하는 리마인드 시간을\n설정해주세요.',
                    type: RemindTimeSettingTextType.description,
                    align: TextAlign.center,
                  ),
                  const SizedBox(height: 89),
                  SizedBox(
                    height: 188,
                    child: CustomTimePicker(
                      onChanged: (time, amPm) {
                        selectedTime = time;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 108,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  '나중에 다시 설정할 수 있어요',
                  style: Font.subTitle14.copyWith(
                    color: const Color(0xFFA6A1AA),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 32,
              left: 24,
              right: 24,
              child: FilledButtonWidget(
                type: ButtonType.primary,
                text: '정했어',
                onPress: () async {
                  try {
                    final status = await Permission.notification.status;
                    // 권한 요청 시도
                    final granted =
                        await NotificationService()
                            .requestNotificationPermission();
                    if (!granted) {
                      if (status.isPermanentlyDenied) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              '알림 권한이 영구적으로 거부되었습니다. 설정 > 몽비 > 알림에서 직접 허용해주세요.',
                            ),
                          ),
                        );
                        await NotificationService()
                            .openAppSettingsIfNeeded(); // 앱 설정으로 이동
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('알림 권한이 거부되었습니다.')),
                        );
                      }
                      return;
                    }

                    // 알림 예약
                    await NotificationService().scheduleDailyReminder(
                      selectedTime,
                    );

                    // 다음 화면으로 이동
                    context.go('/onbording_page');
                  } catch (e) {
                    if (e is PlatformException &&
                        e.code == 'exact_alarms_not_permitted') {
                      await NotificationService()
                          .openExactAlarmSettingsIfNeeded();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('알림 예약 중 오류: ${e.toString()}')),
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
