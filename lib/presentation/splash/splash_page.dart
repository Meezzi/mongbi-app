import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF08063A),
              Color(0xFF3B7EBA),
              Color(0xFF3FAEF4), 
              Color(0xFF9AE4D6),
            ],
            stops: [0.2, 0.42, 0.72, 0.93],
          ),
        ),
      ),
    );
  }
}