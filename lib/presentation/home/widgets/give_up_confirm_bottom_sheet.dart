import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/common/action_button_row.dart';

class GiveUpConfirmBottomSheet extends StatelessWidget {
  const GiveUpConfirmBottomSheet({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onContinue,
    required this.onGiveUp,
  });

  final String title;
  final String subTitle;
  final VoidCallback onContinue;
  final VoidCallback onGiveUp;

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
                'assets/images/sad_mongbi.svg',
                width: 144,
                height: 144,
                fit: BoxFit.contain,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ActionButtonRow(
                  leftText: '계속할래',
                  rightText: '포기할래',
                  onLeftPressed: () {
                    onContinue();
                  },
                  onRightPressed: () {
                    onGiveUp();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
