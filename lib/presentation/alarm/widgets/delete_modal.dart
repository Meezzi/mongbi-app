import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/common/button_type.dart';
import 'package:mongbi_app/presentation/common/filled_button_widget.dart';
import 'package:mongbi_app/presentation/common/ghost_button_widget.dart';
import 'package:mongbi_app/providers/alarm_provider.dart';

class DeleteModal extends StatelessWidget {
  const DeleteModal({super.key});

  @override
  Widget build(BuildContext context) {
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
                  '알림함의 모든 메시지를\n삭제하시나요?',
                  style: Font.title18,
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
                      Consumer(
                        builder: (context, ref, child) {
                          final alarmVm = ref.read(
                            alarmViewModelProvider.notifier,
                          );

                          return Expanded(
                            child: FilledButtonWidget(
                              type: ButtonType.primary,
                              text: '전체 삭제',
                              onPress: () {
                                alarmVm.clearAlarmList();
                                context.pop();
                              },
                            ),
                          );
                        },
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
