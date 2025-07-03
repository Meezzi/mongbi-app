import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/analytics/analytics_helper.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/setting/widgets/logout_account_modal.dart';
import 'package:mongbi_app/presentation/setting/widgets/remove_accont_modal.dart';
import 'package:mongbi_app/presentation/setting/widgets/setting_rounded_list_tile_item.dart';
import 'package:mongbi_app/providers/user_info_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSettingPage extends ConsumerWidget {
  const ProfileSettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(splashViewModelProvider);
    final userResult = userInfo.userList?.first;
    final nickname = userResult?.userNickname ?? '비회원';

    AnalyticsHelper.logScreenView('프로필_설정_페이지');

    return Scaffold(
      appBar: AppBar(
        title: Text('프로필 설정', style: Font.title20),
        titleSpacing: 0,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: SvgPicture.asset('assets/icons/back-arrow.svg'),
        ),
        backgroundColor: const Color(0xFFFAFAFA),
      ),
      backgroundColor: const Color(0xFFFAFAFA),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () async {
              await AnalyticsHelper.logEvent('별명_설정_열림', {
                '별명': nickname,
                '화면_이름': '프로필_설정_페이지',
              });

              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('nicknameChangeState', true);
              await context.push('/nickname_input');
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('별명 설정', style: Font.body16),
                  const SizedBox(width: 8),
                  Text(
                    nickname,
                    style: Font.body16.copyWith(color: const Color(0xFF8C2EFF)),
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    'assets/icons/chevron-right.svg',
                    colorFilter: const ColorFilter.mode(
                      Color(0xFFA6A1AA),
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 8, thickness: 8, color: Color(0xFFF3F2F4)),

          RoundedListTileItem(
            title: '로그아웃',
            isFirst: false,
            isLast: false,
            onTap: () {
              AnalyticsHelper.logButtonClick('로그아웃', '프로필_설정_페이지');
              showDialog(
                context: context,
                barrierDismissible: true,
                barrierColor: Colors.black.withValues(alpha: 0.6),
                builder: (context) => LogoutAccontModal(),
              );
            },
          ),

          RoundedListTileItem(
            title: '계정 탈퇴',
            isFirst: false,
            isLast: false,
            onTap: () {
              AnalyticsHelper.logButtonClick('계정_탈퇴', '프로필_설정_페이지');

              showDialog(
                context: context,
                barrierDismissible: true,
                barrierColor: Colors.black.withValues(alpha: 0.6),
                builder: (context) => RemoveAccontModal(),
              );
            },
          ),
        ],
      ),
    );
  }
}
