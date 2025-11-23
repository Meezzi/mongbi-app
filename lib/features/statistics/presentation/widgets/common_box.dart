import 'package:flutter/material.dart';

class CommonBox extends StatelessWidget {
  const CommonBox({
    super.key,
    required this.title,
    required this.children,
    this.applyBottomPadding = true,
  });

  final Widget title;
  final List<Widget> children;
  final bool applyBottomPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16),
      child: Container(
        padding: EdgeInsets.only(bottom: 32),
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
              padding: EdgeInsets.only(
                top: 24,
                left: 24,
                right: 24,
                bottom: applyBottomPadding ? 16 : 0,
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
