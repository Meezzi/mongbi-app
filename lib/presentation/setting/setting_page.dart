import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/setting/widgets/setting_rounded_list_tile_item.dart';
import 'package:mongbi_app/presentation/setting/widgets/setting_section_card.dart';
import 'package:mongbi_app/presentation/setting/widgets/setting_toggle_switch.dart';
import 'package:mongbi_app/presentation/setting/widgets/setting_user_info_header.dart';
import 'package:mongbi_app/providers/setting_provider.dart';
import 'package:mongbi_app/providers/user_info_provider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

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

    FirebaseAnalytics.instance.logEvent(
      name: 'settings_viewed',
      parameters: {'screen': 'SettingPage'},
    );
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
          loginType: splashState.userList![0].userSocialType,
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
              onTap: () {
                final toggledOn = !isBgmOn;
                toggledOn ? bgmNotifier.turnOn() : bgmNotifier.turnOff();
                FirebaseAnalytics.instance.logEvent(
                  name: 'bgm_toggle',
                  parameters: {
                    'enabled': true.toString(),
                  },
                );
              },
            ),
            RoundedListTileItem(
              title: '알림 설정',
              isFirst: false,
              isLast: true,
              onTap: () {
                FirebaseAnalytics.instance.logEvent(
                  name: 'notification_setting_opened',
                  parameters: {'screen': 'SettingPage'},
                );

                context.push('/alarm_setting');
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        SectionCard(
          title: '고객센터',
          children: [
            RoundedListTileItem(
              title: '고객센터',
              isFirst: false,
              isLast: true,
              onTap: () async {
                await FirebaseAnalytics.instance.logEvent(
                  name: 'help_center_opened',
                  parameters: {'screen': 'SettingPage'},
                );
                await launchUrl(Uri.parse('http://pf.kakao.com/_VGzxin'));
              },
            ),
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
                FirebaseAnalytics.instance.logEvent(
                  name: 'terms_opened',
                  parameters: {'screen': 'SettingPage'},
                );

                final uri = Uri.parse(
                  'https://destiny-yam-088.notion.site/MONGBI-21b1c082f0ac804a8de8f5e499b00078?source=copy_link',
                );
                launchUrl(uri);
              },
            ),
            RoundedListTileItem(
              title: '오픈소스 라이선스',
              isFirst: false,
              isLast: false,
              onTap: () {
                FirebaseAnalytics.instance.logEvent(
                  name: 'license_opened',
                  parameters: {'screen': 'SettingPage'},
                );
                context.push('/license_page');
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
                FirebaseAnalytics.instance.logEvent(
                  name: 'version_info_tapped',
                  parameters: {'screen': 'SettingPage'},
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
