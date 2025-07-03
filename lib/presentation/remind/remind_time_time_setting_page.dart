import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/analytics/analytics_helper.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/common/button_type.dart';
import 'package:mongbi_app/presentation/common/filled_button_widget.dart';
import 'package:mongbi_app/presentation/remind/view_model/remind_time_setting_view_model.dart';
import 'package:mongbi_app/presentation/remind/widgets/remind_time_setting_text_widget.dart';
import 'package:mongbi_app/presentation/remind/widgets/remind_time_setting_widget.dart';
import 'package:mongbi_app/providers/setting_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class RemindTimePickerPage extends ConsumerStatefulWidget {
  const RemindTimePickerPage({super.key, required this.isRemindEnabled});

  final bool? isRemindEnabled;

  @override
  ConsumerState<RemindTimePickerPage> createState() =>
      _RemindTimePickerPageState();
}

class _RemindTimePickerPageState extends ConsumerState<RemindTimePickerPage> {
  TimeOfDay selectedTime = const TimeOfDay(hour: 8, minute: 0);

  @override
  void initState() {
    super.initState();

    AnalyticsHelper.logScreenView('리마인드_시간_설정_페이지');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        toolbarHeight: 56,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Consumer(
            builder: (context, ref, child) {
              final alarmViewModel = ref.read(alarmSettingProvider.notifier);

              return Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (widget.isRemindEnabled ?? false) {
                        await alarmViewModel.toggleReminder();
                      }
                      context.pop();
                    },
                    child: SvgPicture.asset(
                      'assets/icons/back-arrow.svg',
                      width: 24,
                      height: 24,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
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
              Spacer(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    '나중에 다시 설정할 수 있어요',
                    style: Font.subTitle14.copyWith(
                      color: const Color(0xFFA6A1AA),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: FilledButtonWidget(
                  type: ButtonType.primary,
                  text: '정했어',
                  onPress: () async {
                    try {
                      final status = await Permission.notification.status;

                      final granted =
                          await NotificationService()
                              .requestNotificationPermission();

                      if (!granted) {
                        if (status.isPermanentlyDenied) {
                          try {
                            await AnalyticsHelper.logEvent('리마인드_권한_영구_거부', {
                              '화면_이름': '리마인드_시간_설정_페이지',
                              '영구_거부': true,
                            });
                          } catch (e) {
                            print('Failed to log event: $e');
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                '알림 권한이 영구적으로 거부되었습니다. 설정 > 몽비 > 알림에서 직접 허용해주세요.',
                              ),
                            ),
                          );
                          await NotificationService().openAppSettingsIfNeeded();
                        } else {
                          try {
                            await AnalyticsHelper.logEvent('리마인드_권한_거부', {
                              '화면_이름': '리마인드_시간_설정_페이지',
                              '영구_거부': false,
                            });
                          } catch (e) {
                            print('Failed to log event: $e');
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('알림 권한이 거부되었습니다.')),
                          );
                        }
                        return;
                      }

                      await AnalyticsHelper.logEvent('리마인드_시간_선택', {
                        '시간': selectedTime.hour,
                        '분': selectedTime.minute,
                        '화면_이름': '리마인드_시간_설정_페이지',
                      });

                      await NotificationService().scheduleDailyReminder(
                        selectedTime,
                      );
                      ref.read(alarmSettingProvider.notifier).setReminder(true);

                      if (widget.isRemindEnabled ?? false) {
                        context.pop();
                        return;
                      }
                      context.go('/onbording_page');
                    } catch (e) {
                      if (e is PlatformException &&
                          e.code == 'exact_alarms_not_permitted') {
                        await NotificationService()
                            .openExactAlarmSettingsIfNeeded();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('알림 예약 중 오류: ${e.toString()}'),
                          ),
                        );
                      }
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
