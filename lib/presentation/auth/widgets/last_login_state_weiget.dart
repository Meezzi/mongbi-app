import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';

class RecentLoginBubble extends StatelessWidget {
  final String message;

  const RecentLoginBubble({super.key, this.message = '최근에 로그인 했어요 :)'});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BubblePainter(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF8B3EF3),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(message, style: Font.body12.copyWith(color: Colors.white)),
      ),
    );
  }
}

class _BubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFF8B3EF3);
    final path = Path();

    path.moveTo(size.width / 2 - 6, 0);
    path.lineTo(size.width / 2, -6);
    path.lineTo(size.width / 2 + 6, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
