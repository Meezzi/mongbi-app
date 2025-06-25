import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/common/button_type.dart';
import 'package:mongbi_app/presentation/common/filled_button_widget.dart';
import 'package:mongbi_app/presentation/common/ghost_button_widget.dart';
import 'package:mongbi_app/providers/auth_provider.dart' as auth2;
import 'package:shared_preferences/shared_preferences.dart';

class LogoutAccontModal extends ConsumerWidget {
  const LogoutAccontModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(auth2.authViewModelProvider.notifier);

    return Scaffold(
      // Scaffold는 자체 배경이 있으므로 showDialog의 배경을 보이게 하기 위해 투명으로 설정
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.only(top: 32, bottom: 16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '로그아웃하시겠어요?',
                  style: Font.subTitle12.copyWith(color: Color(0xFF76717A)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 24,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GhostButtonWidget(
                          type: ButtonType.primary,
                          text: '로그아웃',
                          onPress: () async {
                            final prefs = await SharedPreferences.getInstance();
                            final loginType = prefs.getString('lastLoginType');
                            bool success = false;

                            try {
                              if (loginType == 'naver') {
                                success =
                                    await ref
                                        .read(
                                          auth2.authViewModelProvider.notifier,
                                        )
                                        .logoutWithNaver();
                              } else if (loginType == 'kakao') {
                                success =
                                    await ref
                                        .read(
                                          auth2.authViewModelProvider.notifier,
                                        )
                                        .logoutWithKakao();
                              } else if (loginType == 'apple') {
                                success =
                                    await ref
                                        .read(
                                          auth2.authViewModelProvider.notifier,
                                        )
                                        .logoutWithApple();
                              }

                              if (success && context.mounted) {
                                await FirebaseAnalytics.instance.logEvent(
                                  name: 'logout_success',
                                  parameters: {
                                    'method': loginType ?? 'unknown',
                                  },
                                );
                                context.go('/social_login');
                              } else {
                                await FirebaseAnalytics.instance.logEvent(
                                  name: 'logout_failed',
                                  parameters: {
                                    'error':
                                        'logout_failed_or_context_unmounted',
                                  },
                                );
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('로그아웃에 실패했습니다.'),
                                  ),
                                );
                              }
                            } catch (e) {
                              await FirebaseAnalytics.instance.logEvent(
                                name: 'logout_failed',
                                parameters: {'error': e.toString()},
                              );
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('로그아웃 중 오류가 발생했습니다.'),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: FilledButtonWidget(
                          type: ButtonType.primary,
                          text: '취소',
                          onPress: () {
                            context.pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
