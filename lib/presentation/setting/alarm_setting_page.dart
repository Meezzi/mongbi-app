import 'dart:async';
import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/analytics/analytics_helper.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/remind/view_model/remind_time_setting_view_model.dart';
import 'package:mongbi_app/presentation/setting/widgets/setting_rounded_list_tile_item.dart';
import 'package:mongbi_app/presentation/setting/widgets/setting_toggle_switch.dart';
import 'package:mongbi_app/providers/setting_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AlarmSettingPage extends ConsumerWidget {
  const AlarmSettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alarmAsyncState = ref.watch(alarmSettingProvider);
    final alarmViewModel = ref.read(alarmSettingProvider.notifier);

    AnalyticsHelper.logScreenView('알림_설정_페이지');

    return alarmAsyncState.when(
      loading:
          () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('에러 발생: $e'))),
      data: (alarmState) {
        return Scaffold(
          appBar: AppBar(
            title: Text('알림 설정', style: Font.title20),
            titleSpacing: 0,
            centerTitle: false,
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: SvgPicture.asset('assets/icons/back-arrow.svg'),
            ),
            backgroundColor: const Color(0xFFFAFAFA),
          ),
          backgroundColor: const Color(0xFFFAFAFA),
          body: Column(
            children: [
              RoundedListTileItem(
                title: '리마인드 알림',
                isFirst: true,
                isLast: false,
                trailing: ToggleSwitch(value: alarmState.isReminder),
                onTap: () async {
                  bool granted = false;

                  if (Platform.isIOS) {
                    final iosPlugin =
                        flutterLocalNotificationsPlugin
                            .resolvePlatformSpecificImplementation<
                              IOSFlutterLocalNotificationsPlugin
                            >();
                    granted =
                        await iosPlugin?.requestPermissions(
                          alert: true,
                          badge: true,
                          sound: true,
                        ) ??
                        false;

                    if (!granted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('알림 권한이 거부되었습니다. 설정에서 직접 허용해주세요.'),
                        ),
                      );
                      await NotificationService().openAppSettingsIfNeeded();
                      return;
                    }
                  } else {
                    final status = await Permission.notification.status;
                    final result = await Permission.notification.request();

                    granted = result.isGranted;

                    if (!granted) {
                      if (status.isPermanentlyDenied) {
                        await FirebaseAnalytics.instance.logEvent(
                          name: 'remind_permission_permanent_denied',
                          parameters: {
                            'screen': 'AlarmSettingPage',
                            'permanently': true,
                          },
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              '알림 권한이 영구적으로 거부되었습니다. 설정 > 몽비 > 알림에서 직접 허용해주세요.',
                            ),
                          ),
                        );
                        await NotificationService().openAppSettingsIfNeeded();
                      } else {
                        await FirebaseAnalytics.instance.logEvent(
                          name: 'remind_permission_denied',
                          parameters: {
                            'screen': 'AlarmSettingPage',
                            'permanently': false,
                          },
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('알림 권한이 거부되었습니다.')),
                        );
                      }
                      return;
                    }
                  }

                  // ✅ 권한이 허용된 경우에만 리마인드 알림 처리
                  final isRemindEnabled = await alarmViewModel.toggleReminder();

                  if (context.mounted && isRemindEnabled) {
                    unawaited(
                      context.push(
                        '/remindtime_time_setting?isRemindEnabled=$isRemindEnabled',
                      ),
                    );
                  }
                },

                enableInkWell: false,
              ),
            ],
          ),
        );
      },
    );
  }
}
