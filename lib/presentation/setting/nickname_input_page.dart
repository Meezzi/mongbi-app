import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/core/secure_storage_service.dart';
import 'package:mongbi_app/presentation/common/button_type.dart';
import 'package:mongbi_app/presentation/common/filled_button_widget.dart';
import 'package:mongbi_app/presentation/setting/widgets/nickname_text_field.dart';
import 'package:mongbi_app/presentation/setting/widgets/nickname_title.dart';
import 'package:mongbi_app/providers/nickname_provider.dart';
import 'package:mongbi_app/providers/user_info_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NicknameInputPage extends ConsumerStatefulWidget {
  const NicknameInputPage({super.key});

  @override
  ConsumerState<NicknameInputPage> createState() => _NicknameInputPageState();
}

class _NicknameInputPageState extends ConsumerState<NicknameInputPage> {
  String nickname = '';
  bool nicknameChanged = false;

  @override
  void initState() {
    super.initState();
    _loadNicknameChangeState();
  }

  Future<void> _loadNicknameChangeState() async {
    final prefs = await SharedPreferences.getInstance();
    final changed = prefs.getBool('nicknameChangeState') ?? false;

    setState(() {
      nicknameChanged = changed;
    });

    // ✅ 진입 로그
    await FirebaseAnalytics.instance.logEvent(
      name: 'nickname_input_viewed',
      parameters: {'from': changed ? 'profile_setting' : 'onboarding'},
    );
  }

  @override
  Widget build(BuildContext context) {
    final isButtonEnabled = nickname.trim().length >= 2;

    return Scaffold(
      appBar:
          nicknameChanged
              ? AppBar(
                backgroundColor: const Color(0xFFFAFAFA),
                elevation: 0,
                titleSpacing: 0,
                title: Row(
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/back-arrow.svg',
                        width: 24,
                        height: 24,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 8),
                    Text('별명 수정', style: Font.title20),
                  ],
                ),
              )
              : null,
      backgroundColor: const Color(0xFFFAFAFA),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 140, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const NicknameTitle(),
            const SizedBox(height: 32),
            NicknameTextField(
              onChanged: (value) => setState(() => nickname = value),
            ),
            const Spacer(),
            FilledButtonWidget(
              type: ButtonType.primary,
              text: '이렇게 불러줘',
              onPress: isButtonEnabled ? _handleNicknameSubmit : null,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Future<void> _handleNicknameSubmit() async {
    try {
      final userId = await SecureStorageService().getUserIdx();
      if (userId == null) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('로그인이 필요합니다.')));
        }
        return;
      }

      await ref
          .read(nicknameViewModelProvider.notifier)
          .updateNickname(userId: userId, nickname: nickname);

      await ref
          .read(splashViewModelProvider.notifier)
          .checkLoginAndFetchUserInfo();

      // ✅ 성공 로그
      await FirebaseAnalytics.instance.logEvent(
        name: 'nickname_submitted',
        parameters: {
          'nickname': nickname,
          'changed': nicknameChanged.toString(),
        },
      );

      if (mounted) {
        if (nicknameChanged) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('nicknameChangeState', false);
          context.pop();
        } else {
          context.go('/remindtime_setting');
        }
      }
    } catch (e) {
      // ✅ 실패 로그
      await FirebaseAnalytics.instance.logEvent(
        name: 'nickname_submit_failed',
        parameters: {
          'nickname': nickname,
          'changed': nicknameChanged.toString(),
        },
      );

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('닉네임 저장 실패: $e')));
      }
    }
  }
}
