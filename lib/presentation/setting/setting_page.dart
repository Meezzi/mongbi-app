import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/setting/widgets/setting_rounded_list_tile_item.dart';
import 'package:mongbi_app/presentation/setting/widgets/setting_section_card.dart';
import 'package:mongbi_app/presentation/setting/widgets/setting_toggle_switch.dart';
import 'package:mongbi_app/presentation/setting/widgets/setting_user_info_header.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isBgmOn = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 24),
      children: [
        UserInfoHeader(
          // TODO: 로그인 사용자의 닉네임과 로그인 타입으로 수정
          nickname: '모몽',
          loginType: '카카오',
          onTap: () {
            context.push('/nickname_input');
          },
        ),
        SizedBox(height: 24),
        SectionCard(
          title: '설정',
          children: [
            RoundedListTileItem(
              title: '배경음악',
              isFirst: true,
              isLast: false,
              trailing: ToggleSwitch(isBgmOn: isBgmOn),
              onTap: () {
                setState(() {
                  isBgmOn = !isBgmOn;
                });
                // TODO: 배경음악 on/off
              },
            ),
            RoundedListTileItem(
              title: '계정 설정',
              isFirst: false,
              isLast: false,
              onTap: () {
                context.push('/account_setting');
              },
            ),
            RoundedListTileItem(
              title: '알림 설정',
              isFirst: false,
              isLast: false,
              onTap: () {
                // TODO: 알림 설정 화면으로 이동
              },
            ),
            RoundedListTileItem(
              title: '멤버쉽',
              isFirst: false,
              isLast: true,
              onTap: () {
                // TODO: 멤버십 화면으로 이동
              },
            ),
          ],
        ),
        SizedBox(height: 16),
        SectionCard(
          title: '기타',
          children: [
            RoundedListTileItem(
              title: '앱 정보',
              isFirst: true,
              isLast: false,
              onTap: () {
                // TODO: 앱 정보 화면으로 이동
              },
            ),
            RoundedListTileItem(
              title: '이용 약관',
              isFirst: false,
              isLast: false,
              onTap: () {
                // TODO: 이용 약관 화면으로 이동
              },
            ),
            RoundedListTileItem(
              title: '오픈소스 라이선스',
              isFirst: false,
              isLast: false,
              onTap: () {
                // TODO: 오픈소스 라이선스 화면으로 이동
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
                    '00.00.0(0000)',
                    // TODO: 버전 정보로 변경
                    style: Font.body16.copyWith(color: Color(0xFF8C2EFF)),
                  ),
                  SizedBox(width: 8),
                  SvgPicture.asset(
                    'assets/icons/chevron-right.svg',
                    colorFilter: ColorFilter.mode(
                      Color(0xFFA6A1AA),
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
              onTap: () {
                // TODO: 버전 정보 화면으로 이동
              },
            ),
          ],
        ),
      ],
    );
  }
}
