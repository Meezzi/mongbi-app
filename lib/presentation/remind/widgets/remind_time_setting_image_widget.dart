import 'package:flutter/material.dart';

class RemindTimeSettingImageWidget extends StatelessWidget {

  const RemindTimeSettingImageWidget({
    super.key,
    required this.assetPath,
    this.width = 280,
    this.height = 280,
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
