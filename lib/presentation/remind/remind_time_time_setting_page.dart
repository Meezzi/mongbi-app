import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/remind/view_model/remind_time_setting_view_model.dart';
import 'package:mongbi_app/presentation/remind/widgets/remind_time_setting_button_widget.dart';
import 'package:mongbi_app/presentation/remind/widgets/remind_time_setting_text_widget.dart';
import 'package:mongbi_app/presentation/remind/widgets/remind_time_setting_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            icon: SvgPicture.asset('assets/icons/back-arrow.svg'),
            onPressed: () => Navigator.pop(context),
            splashRadius: 20,
          ),
        ),
        foregroundColor: Colors.black,
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
              child: RemindTimeSettingButtonWidget(
                onTap: () async {
                  try {
                    await NotificationService().scheduleDailyReminder(
                      selectedTime,
                    );
                    // 알림 등록 성공 후 다음 화면 이동 등 로직
                    await NotificationService().showInstantNotification();
                    print('💚 알림 등록 성공');
                    context.go('/home');
                  } catch (e) {
                    if (e is PlatformException &&
                        e.code == 'exact_alarms_not_permitted') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('정확한 알람 권한이 필요해요! 설정에서 권한을 허용해주세요.'),
                        ),
                      );

                      // 설정으로 이동
                      await NotificationService()
                          .openExactAlarmSettingsIfNeeded();
                    } else {
                      print('알림 등록 실패: $e');
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
