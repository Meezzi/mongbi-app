import 'package:flutter/material.dart';
import 'package:mongbi_app/data/data_sources/naver_auth_data_source.dart';
import 'package:mongbi_app/data/repositories/auth_repository_impl.dart';
import 'package:mongbi_app/domain/use_cases/login_with_naver.dart';
import 'package:mongbi_app/presentation/auth/viewmodels/auth_view_model.dart';
import 'package:mongbi_app/presentation/auth/widgets/apple_login_button_widget.dart';
import 'package:mongbi_app/presentation/auth/widgets/naver_login_button_widget.dart';
import 'package:mongbi_app/presentation/auth/widgets/kakao_login_button_widget.dart';
import 'package:mongbi_app/presentation/auth/widgets/last_login_state_weiget.dart';
import 'package:mongbi_app/presentation/auth/widgets/mongbi_image_widget.dart';
import 'package:mongbi_app/presentation/auth/widgets/text_widgets.dart'; // 이걸로 수정

class SocialLoginPage extends StatelessWidget {
  const SocialLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String lastLoginProvider = "kakao"; //임시 나중에 쉐어드프리퍼런스로 불러올 예정
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(text: '반가워몽!', type: TextType.title),
            CustomText(text: '몽비랑 같이 꿈 보러 갈래?', type: TextType.title),
            SizedBox(height: 62),
            MongbiCharacter(size: 288),
            SizedBox(height: 62),
            CustomText(text: '간편 로그인', type: TextType.login_info),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SocialLoginItem(
                  showRecentBubble: lastLoginProvider == "apple",
                  child: AppleLoginButton(onTap: () {}),
                ),
                const SizedBox(width: 24),
                _SocialLoginItem(
                  showRecentBubble: lastLoginProvider == "kakao",
                  child: KakaoLoginButton(onTap: () {}),
                ),
                const SizedBox(width: 24),
                _SocialLoginItem(
                  showRecentBubble: lastLoginProvider == "naver",
                  child: NaverLoginButton(
                    onTap: () async {
                      final viewModel = AuthViewModel(
                        LoginWithNaver(
                          AuthRepositoryImpl(NaverAuthDataSource()),
                        ),
                      );

                      try {
                        await viewModel.loginWithNaver();
                        final user = viewModel.user;
                        print('✅ 로그인 성공: ${user?.userName}');
                        // TODO: 상태 저장, 화면 이동 등 추가 작업
                      } catch (e) {
                        print('🧨 네이버 로그인 실패: $e');
                        // TODO: 사용자에게 에러 토스트 표시 등
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialLoginItem extends StatelessWidget {
  const _SocialLoginItem({required this.child, this.showRecentBubble = false});
  final Widget child;
  final bool showRecentBubble;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        if (showRecentBubble)
          const Positioned(top: 65, child: RecentLoginBubble()),
        child,
      ],
    );
  }
}
