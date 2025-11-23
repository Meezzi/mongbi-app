import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';

class CustomSpeechBubble extends StatelessWidget {
  const CustomSpeechBubble({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SpeechBubblePainter(
        fillColor: Color(0xFFF4EAFF).withValues(alpha: 0.2),
        strokeColor: Colors.white,
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(17.5, 16, 17.5, 34),
        child: Text(
          text,
          style: Font.body16.copyWith(color: Color(0xFFF4EAFF), fontSize: 16),
        ),
      ),
    );
  }
}

class SpeechBubblePainter extends CustomPainter {
  SpeechBubblePainter({required this.fillColor, required this.strokeColor});

  final Color fillColor;
  final Color strokeColor;

  @override
  void paint(Canvas canvas, Size size) {
    const double radius = 30.0;
    const double tailHeight = 20.0;
    const double tailWidth = 20.0;

    final Path path = Path();

    path.moveTo(radius, 0);

    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);

    path.lineTo(size.width, size.height - tailHeight - radius);
    path.quadraticBezierTo(
      size.width,
      size.height - tailHeight,
      size.width - radius,
      size.height - tailHeight,
    );

    path.lineTo((size.width + tailWidth) / 2, size.height - tailHeight);
    path.lineTo(size.width / 2, size.height);
    path.lineTo((size.width - tailWidth) / 2, size.height - tailHeight);

    path.lineTo(radius, size.height - tailHeight);
    path.quadraticBezierTo(
      0,
      size.height - tailHeight,
      0,
      size.height - tailHeight - radius,
    );

    path.lineTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);

    path.close();

    final fillPaint =
        Paint()
          ..color = fillColor
          ..style = PaintingStyle.fill;

    final strokePaint =
        Paint()
          ..color = strokeColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2;

    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
