import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';

enum RemindTimeSettingTextType { title, description }

class OnboardingText extends StatelessWidget {
  const OnboardingText({
    super.key,
    required this.text,
    required this.type,
    this.align = TextAlign.center,
  });
  final String text;
  final RemindTimeSettingTextType type;
  final TextAlign align;

  @override
  Widget build(BuildContext context) {
    TextStyle style;

    switch (type) {
      case RemindTimeSettingTextType.title:
        style = Font.title20.copyWith(color: Color(0xFF1A181B));
        break;
      case RemindTimeSettingTextType.description:
        style = Font.body16.copyWith(color: Color(0xFF636363));
        break;
    }

    return Text(text, style: style, textAlign: align);
  }
}
