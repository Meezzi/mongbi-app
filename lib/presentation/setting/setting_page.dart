import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/setting/widgets/setting_rounded_list_tile_item.dart';
import 'package:mongbi_app/presentation/setting/widgets/setting_section_card.dart';
import 'package:mongbi_app/presentation/setting/widgets/setting_toggle_switch.dart';
import 'package:mongbi_app/presentation/setting/widgets/setting_user_info_header.dart';
import 'package:mongbi_app/providers/setting_provider.dart';
import 'package:mongbi_app/providers/user_info_provider.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingPage extends ConsumerStatefulWidget {
  const SettingPage({super.key});

  @override
  ConsumerState<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends ConsumerState<SettingPage> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

Future<void> _loadVersion() async {
  final info = await PackageInfo.fromPlatform();
  setState(() {
    _version = '${info.version} ';
  });
}

  @override
  Widget build(BuildContext context) {
    final isBgmOn = ref.watch(bgmProvider);
    final bgmNotifier = ref.read(bgmProvider.notifier);
    final splashState = ref.watch(splashViewModelProvider);

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        UserInfoHeader(
          nickname: splashState.userList![0].userNickname!,
          loginType: splashState.userList![0].userSocialType!,
          onTap: () => context.push('/profile_setting'),
        ),
        const SizedBox(height: 24),
        SectionCard(
          title: '설정',
          children: [
            RoundedListTileItem(
              title: '배경음악',
              isFirst: true,
              isLast: false,
              trailing: ToggleSwitch(value: isBgmOn),
              onTap:
                  () => isBgmOn ? bgmNotifier.turnOff() : bgmNotifier.turnOn(),
            ),
            RoundedListTileItem(
              title: '알림 설정',
              isFirst: false,
              isLast: true,
              onTap: () => context.push('/alarm_setting'),
            ),
            //TODO 맴버쉽 버튼 추후 업데이트 이후 사용
            // RoundedListTileItem(
            //   title: '멤버쉽',
            //   isFirst: false,
            //   isLast: true,
            //   onTap: () {
            //     // TODO: 멤버십 화면으로 이동
            //   },
            // ),
          ],
        ),
        const SizedBox(height: 16),
        SectionCard(
          title: '기타',
          children: [
            RoundedListTileItem(
              title: '이용 약관',
              isFirst: true,
              isLast: false,
              onTap: () {
                // 이동
              },
            ),
            RoundedListTileItem(
              title: '오픈소스 라이선스',
              isFirst: false,
              isLast: false,
              onTap: () {
                // 이동
              },
            ),
            RoundedListTileItem(
              title: '버전 정보',
              isFirst: false,
              isLast: true,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _version.isEmpty ? '0.0.0' : _version,
                    style: Font.body16.copyWith(color: const Color(0xFF8C2EFF)),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
              onTap: () {
                // 이동
              },
            ),
          ],
        ),
      ],
    );
  }
}
