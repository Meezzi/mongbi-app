import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/core/get_responsive_ratio_by_width.dart';

class CustomSnackBar extends StatefulWidget {
  const CustomSnackBar({super.key, this.message = '보여줄 꿈이 없다. 꿈을 알려달라몽!'});

  final String message;

  @override
  State<CustomSnackBar> createState() => CustomSnackBarState();
}

class CustomSnackBarState extends State<CustomSnackBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }

  void show() {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      content: speechBubbleSnackBar(),
      duration: const Duration(hours: 12),
      margin: EdgeInsets.symmetric(
        horizontal: 0,
        vertical: getResponsiveRatioByWidth(context, 8),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void hide() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  Widget speechBubbleSnackBar() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              bottom: -12,
              left: 0,
              right: 0,
              child: Center(
                child: CustomPaint(
                  size: const Size(24, 32),
                  painter: _BubblePointerPainter(color: Color(0xFF8C2EFF)),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: getResponsiveRatioByWidth(context, 8),
                horizontal: getResponsiveRatioByWidth(context, 12),
              ),
              decoration: BoxDecoration(
                color: Color(0xFF8C2EFF),
                borderRadius: BorderRadius.circular(32),
              ),
              child: Text(
                widget.message,
                style: Font.title14.copyWith(
                  fontSize: getResponsiveRatioByWidth(context, 14),
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _BubblePointerPainter extends CustomPainter {
  _BubblePointerPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path =
        Path()
          ..moveTo(0, 0)
          // 가운데 아래로 곡선(뭉툭한 꼭지)
          ..quadraticBezierTo(
            size.width / 2,
            size.height * 1.9, // control point (아래로 더 내려가게)
            size.width,
            0,
          )
          ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
