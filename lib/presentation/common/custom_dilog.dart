import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/presentation/common/action_button_row.dart';

class CustomInputDialog extends StatelessWidget {
  const CustomInputDialog({
    super.key,
    required this.title,
    required this.contentText,
    required this.leftText,
    required this.rightText,
    required this.onLeftPressed,
    required this.onRightPressed,
  });
  final String title;
  final String contentText;
  final String leftText;
  final String rightText;
  final VoidCallback onLeftPressed;
  final VoidCallback onRightPressed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 32),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
             
              child: Text(
                contentText,
                textAlign: TextAlign.center,
                style: Font.title18.copyWith(color: Color(0xFF1A181B)),
              ),
            ),
            const SizedBox(height: 24),
            ActionButtonRow(
              leftText: leftText,
              rightText: rightText,
              onLeftPressed: onLeftPressed,
              onRightPressed: onRightPressed,
            ),
          ],
        ),
      ),
    );
  }
}
