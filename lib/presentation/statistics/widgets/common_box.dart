import 'package:flutter/material.dart';
import 'package:mongbi_app/core/get_responsive_ratio_by_width.dart';

class CommonBox extends StatelessWidget {
  const CommonBox({super.key, required this.title, required this.children});

  final Widget title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: getResponsiveRatioByWidth(context, 16)),
      child: Container(
        padding: EdgeInsets.only(
          bottom: getResponsiveRatioByWidth(context, 32),
        ),
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
                top: getResponsiveRatioByWidth(context, 24),
                left: getResponsiveRatioByWidth(context, 24),
                right: getResponsiveRatioByWidth(context, 24),
                bottom: getResponsiveRatioByWidth(context, 16),
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
