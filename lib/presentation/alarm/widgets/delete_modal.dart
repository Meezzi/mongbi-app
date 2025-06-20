import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mongbi_app/core/font.dart';

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
                      _button(
                        backgroundColor: Color(0xFFF4EAFF),
                        foregroundColor: Color(0xFFB273FF),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x191A181B),
                            blurRadius: 10,
                            offset: Offset(2, 2),
                            spreadRadius: 0,
                          ),
                        ],
                        text: '취소',
                        onTap: () {
                          context.pop();
                        },
                      ),
                      SizedBox(width: 8),
                      _button(
                        backgroundColor: Color(0xFF8B2DFF),
                        foregroundColor: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x331A181B),
                            blurRadius: 10,
                            offset: Offset(2, 2),
                            spreadRadius: 0,
                          ),
                        ],
                        text: '전체 삭제',
                        onTap: () {
                          context.pop();
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

  Widget _button({
    required Color backgroundColor,
    required Color foregroundColor,
    required List<BoxShadow> boxShadow,
    required String text,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(999),
            boxShadow: boxShadow,
          ),
          child: Text(
            text,
            style: Font.title18.copyWith(color: foregroundColor),
          ),
        ),
      ),
    );
  }
}
