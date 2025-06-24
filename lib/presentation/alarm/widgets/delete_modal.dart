import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/common/button_type.dart';
import 'package:mongbi_app/presentation/common/filled_button_widget.dart';
import 'package:mongbi_app/presentation/common/ghost_button_widget.dart';

class DeleteModal extends StatelessWidget {
  const DeleteModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      Expanded(
                        child: FilledButtonWidget(
                          type: ButtonType.primary,
                          text: '전체 삭제',
                          onPress: () {
                            context.pop();
                          },
                        ),
                      ),
                      // _button(
                      //   backgroundColor: Color(0xFF8B2DFF),
                      //   foregroundColor: Colors.white,
                      //   boxShadow: [
                      //     BoxShadow(
                      //       color: Color(0x331A181B),
                      //       blurRadius: 10,
                      //       offset: Offset(2, 2),
                      //       spreadRadius: 0,
                      //     ),
                      //   ],
                      //   text: '전체 삭제',
                      //   onTap: () {
                      //     context.pop();
                      //   },
                      // ),
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
