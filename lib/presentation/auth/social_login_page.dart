import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/presentation/auth/widgets/apple_login_button_widget.dart';
import 'package:mongbi_app/presentation/auth/widgets/kakao_login_button_widget.dart';
import 'package:mongbi_app/presentation/auth/widgets/last_login_state_weiget.dart';
import 'package:mongbi_app/presentation/auth/widgets/mongbi_image_widget.dart';
import 'package:mongbi_app/presentation/auth/widgets/naver_login_button_widget.dart';
import 'package:mongbi_app/presentation/auth/widgets/text_widgets.dart';
import 'package:mongbi_app/providers/auth_provider.dart'; // 이걸로 수정
import 'package:mongbi_app/providers/last_login_provider.dart';

class SocialLoginPage extends ConsumerWidget {
  const SocialLoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncLastProvider = ref.watch(lastLoginProviderProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: asyncLastProvider.when(
        data:
            (lastLoginProvider) => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(text: '반가워몽!', type: TextType.title),
                  CustomText(text: '몽비랑 같이 꿈 보러 갈래?', type: TextType.title),
                  const SizedBox(height: 62),
                  const MongbiCharacter(size: 288),
                  const SizedBox(height: 62),
                  CustomText(text: '간편 로그인', type: TextType.login_info),
                  const SizedBox(height: 16),
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
                        child: KakaoLoginButton(
                          onTap: () async {
                            final authViewModel = ref.read(
                              authViewModelProvider.notifier,
                            );
                            try {
                              await authViewModel.loginWithKakao();
                              print('✅ 로그인 성공');
                            } catch (e) {
                              print('🧨 로그인 실패: $e');
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 24),
                      _SocialLoginItem(
                        showRecentBubble: lastLoginProvider == "naver",
                        child: NaverLoginButton(
                          onTap: () async {
                            final authViewModel = ref.read(
                              authViewModelProvider.notifier,
                            );
                            try {
                              await authViewModel.loginWithNaver();
                              print('✅ 로그인 성공');
                            } catch (e) {
                              print('🧨 로그인 실패: $e');
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('에러 발생: $e')),
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
