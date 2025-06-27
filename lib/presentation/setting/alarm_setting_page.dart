// AlarmSettingPage.dart
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/setting/widgets/setting_rounded_list_tile_item.dart';
import 'package:mongbi_app/presentation/setting/widgets/setting_toggle_switch.dart';
import 'package:mongbi_app/providers/setting_provider.dart';

class AlarmSettingPage extends ConsumerWidget {
  const AlarmSettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alarmState = ref.watch(alarmSettingProvider);
    final alarmViewModel = ref.read(alarmSettingProvider.notifier);

    FirebaseAnalytics.instance.logEvent(
      name: 'alarm_setting_viewed',
      parameters: {'screen': 'AlarmSettingPage'},
    );

    if (!alarmState.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

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
          // TODO : 일단 숨김
          // RoundedListTileItem(
          //   title: '전체 알림',
          //   isFirst: true,
          //   isLast: false,
          //   trailing: ToggleSwitch(value: alarmState.isAll),
          //   onTap: () {
          //     alarmViewModel.toggleAll();
          //     FirebaseAnalytics.instance.logEvent(
          //       name: 'alarm_toggle_changed',
          //       parameters: {'type': 'all', 'enabled': !alarmState.isAll},
          //     );
          //   },
          //   enableInkWell: false,
          // ),
          // const Divider(height: 0, thickness: 8, color: Color(0xFFF3F2F4)),
          RoundedListTileItem(
            title: '리마인드 알림',
            isFirst: true,
            isLast: false,
            trailing: ToggleSwitch(value: alarmState.isReminder),
            onTap: () {
              alarmViewModel.toggleReminder();
              // FirebaseAnalytics.instance.logEvent(
              //   name: 'alarm_toggle_changed',
              //   parameters: {
              //     'type': 'reminder',
              //     'enabled': !alarmState.isReminder,
              //   },
              // );
            },
            enableInkWell: false,
          ),
        ],
      ),
    );
  }
}
