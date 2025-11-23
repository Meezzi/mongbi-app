import 'package:flutter/material.dart';

class MongbiCharacter extends StatelessWidget {

  const MongbiCharacter({super.key, this.size = 400});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/mongbi.webp',
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
                          