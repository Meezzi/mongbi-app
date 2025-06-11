import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mongbi_app/core/font.dart';

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
      color: isActive ? Color(0xFF3B136B) : Color(0xffFCF6FF),
      child: AppBar(
        systemOverlayStyle:
            isActive ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        titleSpacing: horizontalPadding,
        title: AnimatedDefaultTextStyle(
          duration: Duration(milliseconds: 200),
          style: Font.title20.copyWith(
            color: isActive ? Colors.white : Color(0xff1A181B),
          ),
          // TODO : 나중에 사용자 닉네임으로 변경
          child: Text('모몽의 꿈 기록'),
        ),
      ),
    );
  }
}
