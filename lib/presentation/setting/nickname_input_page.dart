import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/analytics/analytics_helper.dart';
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

    await AnalyticsHelper.logScreenView(changed ? '별명_수정_페이지' : '별명_입력_페이지');
  }

  @override
  Widget build(BuildContext context) {
    final isButtonEnabled = RegExp(r'^[가-힣]{2,10}$').hasMatch(nickname.trim());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:
          nicknameChanged
              ? AppBar(
                backgroundColor: const Color(0xFFFAFAFA),
                title: Text('별명 수정', style: Font.title20),
                titleSpacing: 0,
                centerTitle: false,
                leading: IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/back-arrow.svg',
                    width: 24,
                    height: 24,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
              : null,
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 140),
              const NicknameTitle(),
              SizedBox(height: 32),
              NicknameTextField(
                onChanged: (value) => setState(() => nickname = value),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: FilledButtonWidget(
                  type: ButtonType.primary,
                  text: '이렇게 불러줘',
                  onPress: isButtonEnabled ? _handleNicknameSubmit : null,
                ),
              ),
            ],
          ),
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

      await AnalyticsHelper.logEvent('별명_저장_성공', {
        '별명': nickname,
        '수정_여부': nicknameChanged.toString(),
      });

      if (mounted) {
        if (nicknameChanged) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('nicknameChangeState', false);
          context.pop();
        } else {
          await context.push('/remindtime_setting');
        }
      }
    } catch (e) {
      await AnalyticsHelper.logEvent('별명_저장_실패', {
        '별명': nickname,
        '수정_여부': nicknameChanged.toString(),
      });

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('닉네임 저장 실패: $e')));
      }
    }
  }
}
