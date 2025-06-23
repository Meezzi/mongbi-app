import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/secure_storage_service.dart';
import 'package:mongbi_app/presentation/setting/widgets/nickname_submit_button.dart';
import 'package:mongbi_app/presentation/setting/widgets/nickname_text_field.dart';
import 'package:mongbi_app/presentation/setting/widgets/nickname_title.dart';
import 'package:mongbi_app/providers/nickname_provider.dart';

class NicknameInputPage extends ConsumerStatefulWidget {
  const NicknameInputPage({super.key});

  @override
  ConsumerState<NicknameInputPage> createState() => _NicknameInputPageState();
}

class _NicknameInputPageState extends ConsumerState<NicknameInputPage> {
  String nickname = '';

  @override
  Widget build(BuildContext context) {
    final isButtonEnabled = nickname.trim().isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 84, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const NicknameTitle(),
            const SizedBox(height: 32),
            NicknameTextField(
              onChanged: (value) => setState(() => nickname = value),
              nickname: nickname,
            ),
            const Spacer(),
            NicknameSubmitButton(
              enabled: isButtonEnabled,
              onTap: () async {
                if (!isButtonEnabled) return;

                try {
                  final userId = await SecureStorageService().getUserIdx();
                  if (userId ==  null) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('로그인이 필요합니다.')),
                      );
                    }
                    return;
                  }
                  await ref
                      .read(nicknameViewModelProvider.notifier)
                      .updateNickname(userId: userId, nickname: nickname);
                  if (mounted) {
                    context.go('/remindtime_setting');
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('닉네임 저장 실패: $e')));
                  }
                }
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
