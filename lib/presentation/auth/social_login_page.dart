import 'package:flutter/material.dart';
import 'package:mongbi_app/presentation/auth/widgets/apple_login_button_widget.dart';
import 'package:mongbi_app/presentation/auth/widgets/google_login_button_widget.dart';
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
                  showRecentBubble: lastLoginProvider == "google",
                  child: GoogleLoginButton(onTap: () {}),
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
