import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/setting/widgets/logout_confirm_dialog.dart';
import 'package:mongbi_app/presentation/setting/widgets/setting_rounded_list_tile_item.dart';
import 'package:mongbi_app/providers/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSettingPage extends ConsumerWidget {
  const ProfileSettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(authViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('프로필 설정', style: Font.title20),
        titleSpacing: 0,
        backgroundColor: Color(0xFFFAFAFA),
      ),
      backgroundColor: Color(0xFFFAFAFA),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              context.push('/nickname_input');
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TODO: 사용자 별명
                  Text('별명 설정', style: Font.body16),
                  SizedBox(width: 8),
                  Text(
                    user!.userNickname ?? '',
                    style: Font.body16.copyWith(color: Color(0xFF8C2EFF)),
                  ),
                  Spacer(),
                  SvgPicture.asset(
                    'assets/icons/chevron-right.svg',
                    colorFilter: ColorFilter.mode(
                      Color(0xFFA6A1AA),
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Divider(height: 8, thickness: 8, color: Color(0xFFF3F2F4)),
          RoundedListTileItem(
            title: '로그아웃',
            isFirst: false,
            isLast: false,
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: true,
                builder:
                    (context) => LogoutConfirmDialog(
                      onConfirm: () async {
                        final prefs = await SharedPreferences.getInstance();
                        final loginType = prefs.getString('lastLoginType');

                        bool success = false;
                        if (loginType == 'naver') {
                          success =
                              await ref
                                  .read(authViewModelProvider.notifier)
                                  .logoutWithNaver();
                        } else if (loginType == 'kakao') {
                          success =
                              await ref
                                  .read(authViewModelProvider.notifier)
                                  .logoutWithKakao();
                        }

                        if (success && context.mounted) {
                          context.go('/social_login');
                        } else {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('로그아웃에 실패했습니다.')),
                          );
                        }
                      },
                    ),
              );
            },
          ),

          RoundedListTileItem(
            title: '계정 탈퇴',
            isFirst: false,
            isLast: false,
            onTap: () {
              // TODO: 계정 탈퇴
            },
          ),
        ],
      ),
    );
  }
}
