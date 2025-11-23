import 'dart:ui';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomFlDotPainter extends FlDotPainter {
  CustomFlDotPainter({
    required this.radius,
    required this.color,
    required this.text,
    required this.textStyle,
  });

  final double radius;
  final Color color;
  final String text;
  final TextStyle textStyle;

  @override
  void draw(Canvas canvas, FlSpot spot, Offset offsetInCanvas) {
    // 원 그리기
    final paint = Paint()..color = color;
    canvas.drawCircle(offsetInCanvas, radius, paint);

    // 텍스트 그리기
    final textSpan = TextSpan(text: text, style: textStyle);
    final tp = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    final textOffset = offsetInCanvas - Offset(tp.width / 2, tp.height / 2);
    tp.paint(canvas, textOffset);
  }

  @override
  Size getSize(FlSpot spot) => Size(radius * 2, radius * 2);

  // [필수] mainColor getter 구현
  @override
  Color get mainColor => color;

  // [필수] lerp 구현
  @override
  FlDotPainter lerp(FlDotPainter a, FlDotPainter b, double t) {
    if (a is CustomFlDotPainter && b is CustomFlDotPainter) {
      return CustomFlDotPainter(
        radius: lerpDouble(a.radius, b.radius, t)!,
        color: Color.lerp(a.color, b.color, t)!,
        text: t < 0.5 ? a.text : b.text,
        textStyle: t < 0.5 ? a.textStyle : b.textStyle,
      );
    }
    return this;
  }

  // [필수] props getter 구현 (EquatableMixin)
  @override
  List<Object?> get props => [radius, color, text, textStyle];
}
