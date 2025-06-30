import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/analytics_helper.dart';
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

    AnalyticsHelper.logScreenView('설정_페이지');
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
                  parameters: {'enabled': true.toString()},
                );
              },
            ),
            RoundedListTileItem(
              title: '알림 설정',
              isFirst: false,
              isLast: true,
              onTap: () {
                AnalyticsHelper.logButtonClick('알림_설정_열림', '설정_페이지');

                context.push('/alarm_setting');
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        SectionCard(
          title: '기타',
          children: [
            RoundedListTileItem(
              title: '고객센터',
              isFirst: false,
              isLast: true,
              onTap: () async {
                await AnalyticsHelper.logButtonClick('고객센터_열림', '설정_페이지');
                await launchUrl(Uri.parse('http://pf.kakao.com/_VGzxin'));
              },
            ),
            RoundedListTileItem(
              title: '이용 약관',
              isFirst: true,
              isLast: false,
              onTap: () {
                AnalyticsHelper.logButtonClick('이용약관_열림', '설정_페이지');

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
                AnalyticsHelper.logButtonClick('오픈소스_라이선스_열림', '설정_페이지');
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
                AnalyticsHelper.logButtonClick('버전_정보_탭', '설정_페이지');
              },
            ),
          ],
        ),
      ],
    );
  }
}

