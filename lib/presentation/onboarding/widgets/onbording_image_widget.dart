import 'package:flutter/material.dart';

class OnboardingImage extends StatelessWidget {

  const OnboardingImage({
    super.key,
    required this.assetPath,
    this.width = 266,
    this.height = 950,
  });
  final String assetPath;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      width: width,
      height: height,
      fit: BoxFit.contain,
    );
  }
}
