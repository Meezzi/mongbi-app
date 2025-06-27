import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
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

    FirebaseAnalytics.instance.logEvent(
      name: 'alarm_setting_viewed',
      parameters: {'screen': 'AlarmSettingPage'},
    );

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
                  final status = await Permission.notification.status;
                  final granted =
                      await NotificationService()
                          .requestNotificationPermission();
                  if (!granted) {
                    if (status.isPermanentlyDenied) {
                      await FirebaseAnalytics.instance.logEvent(
                        name: 'remind_permission_permanent_denied',
                        parameters: {
                          'screen': 'RemindTimePickerPage',
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
                          'screen': 'RemindTimePickerPage',
                          'permanently': false,
                        },
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('알림 권한이 거부되었습니다.')),
                      );
                    }
                    return;
                  } else {
                    final isRemindEnabled =
                        await alarmViewModel.toggleReminder();

                    if (context.mounted && isRemindEnabled) {
                      unawaited(
                        context.push(
                          '/remindtime_time_setting?isRemindEnabled=$isRemindEnabled',
                        ),
                      );
                    }
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
