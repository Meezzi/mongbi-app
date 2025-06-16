import 'package:flutter/material.dart';

class ExpandingDotsIndicator extends StatelessWidget {
  final int currentPage;
  final int count;
  final double dotHeight;
  final double dotWidth;
  final double expandedDotWidth;
  final Color activeColor;
  final Color inactiveColor;
  final Duration animationDuration;

  const ExpandingDotsIndicator({
    super.key,
    required this.currentPage,
    required this.count,
    this.dotHeight = 8.0,
    this.dotWidth = 8.0,
    this.expandedDotWidth = 24.0,
    this.activeColor = const Color(0xFF8C2EFF),
    this.inactiveColor = const Color(0xFFD6D4D8),
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        final isActive = index == currentPage;
        return AnimatedContainer(
          duration: animationDuration,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          height: dotHeight,
          width: isActive ? expandedDotWidth : dotWidth,
          decoration: BoxDecoration(
            color: isActive ? activeColor : inactiveColor,
            borderRadius: BorderRadius.circular(dotHeight),
          ),
        );
      }),
    );
  }
}