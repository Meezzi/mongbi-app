import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/core/responsive_layout.dart';
import 'package:mongbi_app/presentation/auth/widgets/mongbi_image_widget.dart';
import 'package:mongbi_app/presentation/dream/widgets/custom_button.dart';

class MongbiDialog extends StatelessWidget {
  const MongbiDialog({
    super.key,
    required this.content,
    required this.buttonText,
    required this.onSubmit,
  });

  final String content;
  final String buttonText;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: Container(
        width: ResponsiveLayout.getWidth(context),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                content,
                style: Font.title18.copyWith(color: Color(0xFF1A181B)),
                textAlign: TextAlign.center,
              ),
              MongbiCharacter(size: 144),
              SizedBox(height: 8),
              CustomButton(text: buttonText, onSubmit: onSubmit),
            ],
          ),
        ),
      ),
    );
  }
}
