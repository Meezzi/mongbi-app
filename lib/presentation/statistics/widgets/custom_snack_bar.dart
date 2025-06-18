import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';

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
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void hide() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  Widget speechBubbleSnackBar() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 아래쪽 삼각형 꼭지
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
        // 말풍선 본체
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: Color(0xFF8C2EFF), // 이미지와 유사한 진한 보라색
              borderRadius: BorderRadius.circular(32),
            ),
            child: Text(
              widget.message,
              style: Font.title14.copyWith(fontSize: 14, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
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
