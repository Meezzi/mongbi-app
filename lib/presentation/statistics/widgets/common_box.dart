import 'package:flutter/material.dart';

class CommonBox extends StatelessWidget {
  const CommonBox({super.key, required this.title, required this.children});

  final Widget title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Container(
        padding: const EdgeInsets.only(bottom: 32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 10,
              color: Color(0x0D7F2AE8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 24,
                left: 24,
                right: 24,
                bottom: 16,
              ),
              child: title, // 타이틀 영역을 위젯으로 받음
            ),
            ...children,
          ],
        ),
      ),
    );
  }
}
