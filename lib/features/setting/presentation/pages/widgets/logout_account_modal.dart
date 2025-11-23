import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/analytics/analytics_helper.dart';
import 'package:mongbi_app/core/responsive_layout.dart';
import 'package:mongbi_app/presentation/common/button_type.dart';
import 'package:mongbi_app/presentation/common/filled_button_widget.dart';
import 'package:mongbi_app/presentation/common/ghost_button_widget.dart';
import 'package:mongbi_app/providers/auth_provider.dart' as auth2;
import 'package:shared_preferences/shared_preferences.dart';

class LogoutAccontModal extends ConsumerWidget {
  const LogoutAccontModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTextStyle(
      style: TextStyle(),
      child: Center(
        child: SizedBox(
          width: ResponsiveLayout.getWidth(context),
          child: Padding(
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
                      style: TextStyle(
                        fontFamily: 'NanumSquareRound',
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        height: 24 / 18,
                        color: Color(0xff1A181B),
                      ),
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
                              text: '취소',
                              onPress: () {
                                context.pop();
                              },
                            ),
                          ),

                          SizedBox(width: 8),
                          Expanded(
                            child: FilledButtonWidget(
                              type: ButtonType.primary,
                              text: '로그아웃',
                              onPress: () async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                final loginType = prefs.getString(
                                  'lastLoginType',
                                );
                                bool success = false;

                                try {
                                  if (loginType == 'naver') {
                                    success =
                                        await ref
                                            .read(
                                              auth2
                                                  .authViewModelProvider
                                                  .notifier,
                                            )
                                            .logoutWithNaver();
                                  } else if (loginType == 'kakao') {
                                    success =
                                        await ref
                                            .read(
                                              auth2
                                                  .authViewModelProvider
                                                  .notifier,
                                            )
                                            .logoutWithKakao();
                                  } else if (loginType == 'apple') {
                                    success =
                                        await ref
                                            .read(
                                              auth2
                                                  .authViewModelProvider
                                                  .notifier,
                                            )
                                            .logoutWithApple();
                                  }

                                  if (success && context.mounted) {
                                    await AnalyticsHelper.logEvent('로그아웃_성공', {
                                      '로그인_방식': loginType ?? '알수없음',
                                      '화면_이름': '로그아웃_모달',
                                    });
                                    context.go('/social_login');
                                  } else {
                                    await AnalyticsHelper.logEvent('로그아웃_실패', {
                                      '에러': '로그아웃_실패_또는_컨텍스트_언마운트됨',
                                      '화면_이름': '로그아웃_모달',
                                    });
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('로그아웃에 실패했습니다.'),
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  await AnalyticsHelper.logEvent('로그아웃_실패', {
                                    '에러': e.toString(),
                                    '화면_이름': '로그아웃_모달',
                                  });
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
