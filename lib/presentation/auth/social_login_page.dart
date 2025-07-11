import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/analytics/analytics_helper.dart';
import 'package:mongbi_app/core/exceptions/auth_custom_exception.dart';
import 'package:mongbi_app/presentation/auth/widgets/apple_login_button_widget.dart';
import 'package:mongbi_app/presentation/auth/widgets/kakao_login_button_widget.dart';
import 'package:mongbi_app/presentation/auth/widgets/last_login_state_weiget.dart';
import 'package:mongbi_app/presentation/auth/widgets/mongbi_image_widget.dart';
import 'package:mongbi_app/presentation/auth/widgets/naver_login_button_widget.dart';
import 'package:mongbi_app/presentation/auth/widgets/text_widgets.dart';
import 'package:mongbi_app/presentation/common/custom_snack_bar.dart';
import 'package:mongbi_app/presentation/terms/widgets/terms_bottom_sheet_layout_widget.dart';
import 'package:mongbi_app/providers/auth_provider.dart';
import 'package:mongbi_app/providers/last_login_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SocialLoginPage extends ConsumerWidget {
  const SocialLoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncLastProvider = ref.watch(lastLoginProviderProvider);

    Future<void> _navigateBasedOnReminderTime() async {
      final prefs = await SharedPreferences.getInstance();
      final hour = prefs.getInt('reminder_hour');
      final minute = prefs.getInt('reminder_minute');

      await Future.delayed(const Duration(milliseconds: 500)); // 스플래시 느낌 약간 주기

      if (hour != null && minute != null) {
        context.pushReplacement('/onbording_page'); // 알림 시간 있음
      } else {
        context.pushReplacement('/remindtime_setting'); // 없음
      }
    }

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
                      if (Platform.isIOS) ...[
                        _SocialLoginItem(
                          child: AppleLoginButton(
                            onTap:
                                () => _login(
                                  ref,
                                  context,
                                  ref
                                      .read(authViewModelProvider.notifier)
                                      .loginWithApple,
                                  'apple',
                                ),
                          ),
                        ),
                        const SizedBox(width: 24),
                      ],
                      _SocialLoginItem(
                        child: KakaoLoginButton(
                          onTap:
                              () => _login(
                                ref,
                                context,
                                ref
                                    .read(authViewModelProvider.notifier)
                                    .loginWithKakao,
                                'kakao',
                              ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      _SocialLoginItem(
                        child: NaverLoginButton(
                          onTap:
                              () => _login(
                                ref,
                                context,
                                ref
                                    .read(authViewModelProvider.notifier)
                                    .loginWithNaver,
                                'naver',
                              ),
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

  Future<void> _login(
    WidgetRef ref,
    BuildContext context,
    Future<bool> Function() loginMethod,
    String provider,
  ) async {
    await AnalyticsHelper.logButtonClick(
      '${provider}_login',
      'SocialLoginPage',
    );

    try {
      final isAgreed = await loginMethod();

      await AnalyticsHelper.logLogin(provider, 'SocialLoginPage');

      if (isAgreed) {
        final prefs = await SharedPreferences.getInstance();
        final hour = prefs.getInt('reminder_hour');
        final minute = prefs.getInt('reminder_minute');

        if (hour != null && minute != null) {
          context.go('/onbording_page'); // 알림 시간 있음
        } else {
          context.go('/remindtime_setting'); // 알림 시간 없음
        }
      } else {
        await showModalBottomSheet(
          context: context,
          isScrollControlled: false,
          isDismissible: false,
          backgroundColor: const Color.fromARGB(60, 0, 0, 0),
          builder: (_) => const TermsBottomSheet(),
        );
      }
    } catch (e) {
      if (e is! AuthCancelledException) {
        await AnalyticsHelper.logLoginFailure(
          provider,
          'SocialLoginPage',
          e.toString(),
        );
      }
      _handleLoginError(context, e);
    }
  }

  void _handleLoginError(BuildContext context, dynamic error) {
    String message;

    if (error is AuthCancelledException) {
      message = '로그인이 취소되었습니다.';
    } else if (error is WithdrawnUserException) {
      message = error.message;
    } else if (error is AuthFailedException) {
      message = error.message;
    } else {
      message = '로그인 중 오류가 발생했습니다.';
    }

    ScaffoldMessenger.of(context).showSnackBar(customSnackBar(message, 40, 2));
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
