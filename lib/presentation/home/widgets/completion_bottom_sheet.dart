import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/common/button_type.dart';
import 'package:mongbi_app/presentation/common/filled_button_widget.dart';

class CompletionBottomSheet extends StatelessWidget {
  const CompletionBottomSheet({
    super.key,
    required this.title,
    required this.subTitle,
    required this.buttonText,
    required this.onButtonPressed,
  });

  final String title;
  final String subTitle;
  final String buttonText;
  final VoidCallback onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 32),
              Text(title, style: Font.title18),
              Text(
                subTitle,
                style: Font.subTitle12.copyWith(color: Color(0xFF76717A)),
              ),
              SizedBox(height: 8),
              SvgPicture.asset(
                'assets/images/happy_mongbi.svg',
                width: 144,
                height: 144,
                fit: BoxFit.contain,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: FilledButtonWidget(
                  type: ButtonType.primary,
                  text: '내가 꾼 꿈이야',
                  onPress: onButtonPressed,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
