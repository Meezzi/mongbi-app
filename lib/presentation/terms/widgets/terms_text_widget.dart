import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/core/get_responsive_ratio_by_width.dart';

class TermsHeaderText extends StatelessWidget {
  const TermsHeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '몽비 이용을 위한\n이용약관 동의가 필요해몽',
          style:  Font.title18.copyWith(
            fontSize: getResponsiveRatioByWidth(context, 18),
            color: Colors.black
          )
        ),
      ],
    );
  }
}