import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.onSubmit});

  final String text;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onSubmit,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Color(0xff8c2eff)),
        ),
        child: Text(text, style: Font.title18.copyWith(color: Colors.white)),
      ),
    );
  }
}
