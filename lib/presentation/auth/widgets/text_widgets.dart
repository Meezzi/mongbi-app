import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';

enum TextType { title, login_info }

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.type = TextType.login_info,
    this.color,
  });
  final String text;
  final TextType type;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    TextStyle style;

    switch (type) {
      case TextType.title:
        style = Font.title16.copyWith(color: Color(0xFF1A181B));
        break;
      case TextType.login_info:
        style = Font.subTitle16.copyWith(color: Color(0xFFA6A1AA));
        break;
    }

    return Text(text, style: style);
  }
}
