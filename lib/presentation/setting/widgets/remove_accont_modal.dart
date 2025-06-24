import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/common/button_type.dart';
import 'package:mongbi_app/presentation/common/custom_snack_bar.dart';
import 'package:mongbi_app/presentation/common/filled_button_widget.dart';
import 'package:mongbi_app/presentation/common/ghost_button_widget.dart';
import 'package:mongbi_app/providers/auth_provider.dart';

class RemoveAccontModal extends ConsumerWidget {
  const RemoveAccontModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(authViewModelProvider.notifier);

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
                  '정말 몽비를 탈퇴 하시겠어요?',
                  style: Font.title18,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4),
                Text(
                  '탈퇴 후 30일간 회원가입이 불가합니다.',
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
                          text: '탈퇴하기',
                          onPress: () async {
                            final isRemoved = await user.removeAccount();

                            if (context.mounted) {
                              if (isRemoved) {
                                context.go('/social_login');
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  customSnackBar('오류로 인해 탈퇴가 중지 되었습니다'),
                                );
                              }
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: FilledButtonWidget(
                          type: ButtonType.primary,
                          text: '아니오',
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
