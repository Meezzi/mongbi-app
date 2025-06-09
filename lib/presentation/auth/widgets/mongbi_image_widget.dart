import 'package:flutter/material.dart';

class MongbiCharacter extends StatelessWidget {
  final double size;

  const MongbiCharacter({super.key, this.size = 400});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/mongbi.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
