import 'package:flutter/material.dart';

/// 바텀네비게이션바에 연결된 페이지(홈, 기록, 통계, 마이페이지)는 위젯을 그대로 사용
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key, required this.child});

  final Widget child;

  /// 바텀네비게이션바에
  /// 연결되지 않은 페이지(모달, buildFadeTransitionPage함수 사용하는 페이지, scaffold사용하는 페이지)는
  /// 정적 메서드 사용
  static double getWidth(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= 480 ? 480 : double.infinity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 480) {
            return Center(child: SizedBox(width: 480, child: child));
          } else {
            return child;
          }
        },
      ),
    );
  }
}
