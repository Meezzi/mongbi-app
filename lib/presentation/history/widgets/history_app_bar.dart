import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HistoryAppBar extends StatelessWidget {
  const HistoryAppBar({
    super.key,
    required this.isActive,
    required this.horizontalPadding,
  });

  final bool isActive;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
        // 앱바의 배경
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors:
              isActive
                  ? [Color(0xFF3B136B), Color(0xFF3B136B)]
                  : [Color(0xFFFDF8FF), Color(0xFFFDF8FF)],
        ),
      ),
      child: AppBar(
        systemOverlayStyle:
            isActive ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        titleSpacing: horizontalPadding,
        title: AnimatedDefaultTextStyle(
          duration: Duration(milliseconds: 200),
          style: TextStyle(
            fontFamily: 'NanumSquareRound',
            fontWeight: FontWeight.w800,
            fontSize: 20,
            height: 28 / 20,
            color: isActive ? Colors.white : Color(0xff1A181B),
          ),

          // TODO : 나중에 사용자 닉네임으로 변경
          child: Text('모몽의 꿈 기록'),
        ),
      ),
    );
  }
}
