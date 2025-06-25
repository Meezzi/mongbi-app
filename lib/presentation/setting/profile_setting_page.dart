import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/setting/widgets/logout_account_modal.dart';
import 'package:mongbi_app/presentation/setting/widgets/logout_confirm_dialog.dart';
import 'package:mongbi_app/presentation/setting/widgets/remove_accont_modal.dart';
import 'package:mongbi_app/presentation/setting/widgets/setting_rounded_list_tile_item.dart';
import 'package:mongbi_app/providers/auth_provider.dart' as auth2;
import 'package:mongbi_app/providers/user_info_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSettingPage extends ConsumerWidget {
  const ProfileSettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(splashViewModelProvider);
    final userResult = userInfo.userList?.first;
    final nickname = userResult?.userNickname ?? '비회원';

    FirebaseAnalytics.instance.logEvent(
      name: 'profile_setting_viewed',
      parameters: {'screen': 'ProfileSettingPage'},
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('프로필 설정', style: Font.title20),
        titleSpacing: 0,
        backgroundColor: const Color(0xFFFAFAFA),
      ),
      backgroundColor: const Color(0xFFFAFAFA),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () async {
              await FirebaseAnalytics.instance.logEvent(
                name: 'nickname_setting_opened',
                parameters: {'nickname': nickname},
              );

              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('nicknameChangeState', true);
              context.push('/nickname_input');
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
              FirebaseAnalytics.instance.logEvent(
                name: 'logout_attempted',
                parameters: {'screen': 'ProfileSettingPage'},
              );
              showDialog(
                context: context,
                barrierDismissible: false, // 배경 터치로 닫히지 않음!
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
              FirebaseAnalytics.instance.logEvent(
                name: 'account_deletion_tapped',
                parameters: {'screen': 'ProfileSettingPage'},
              );

              showDialog(
                context: context,
                barrierDismissible: false, // 배경 터치로 닫히지 않음!
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
