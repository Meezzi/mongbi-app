import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SvgPicture.asset(
        'assets/images/splash_bg.svg',
        fit: BoxFit.cover,
        width: double.infinity,
        height:  double.infinity,
      ),
    );
  }
}