import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/setting/widgets/setting_rounded_list_tile_item.dart';
import 'package:mongbi_app/presentation/setting/widgets/setting_toggle_switch.dart';
import 'package:mongbi_app/providers/setting_provider.dart';

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
