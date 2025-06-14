import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: Text('알림 설정', style: Font.title20),
        titleSpacing: 0,
        backgroundColor: Color(0xFFFAFAFA),
      ),
      backgroundColor: Color(0xFFFAFAFA),
      body: Column(
        children: [
          RoundedListTileItem(
            title: '전체 알림',
            isFirst: true,
            isLast: false,
            trailing: ToggleSwitch(value: alarmState.isAll),
            onTap: alarmViewModel.toggleAll,
          ),

          Divider(height: 0, thickness: 8, color: Color(0xFFF3F2F4)),

          RoundedListTileItem(
            title: '리마인드 알림',
            isFirst: true,
            isLast: false,
            trailing: ToggleSwitch(value: alarmState.isReminder),
            onTap: alarmViewModel.toggleReminder,
          ),

          RoundedListTileItem(
            title: '챌린지 알림',
            isFirst: false,
            isLast: true,
            trailing: ToggleSwitch(value: alarmState.isChallenge),
            onTap: alarmViewModel.toggleChallenge,
          ),
        ],
      ),
    );
  }
}
