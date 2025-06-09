import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _floatingAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 100),
    )..repeat(reverse: true);

    _floatingAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, 0.02), 
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
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
          Image.asset(
            'assets/images/star.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '안녕, 난 몽비!',
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // const SizedBox(height: 4),
                const Text(
                  '꿈을 먹는 도깨비다몽',
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.035),
                SlideTransition(
                  position: _floatingAnimation,
                  child: Image.asset(
                    'assets/images/splash_mongbi.png',
                    width: screenHeight * 0.38,
                    height: screenHeight * 0.38,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
