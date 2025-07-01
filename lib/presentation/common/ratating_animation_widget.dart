import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TouchScaleWidget extends StatefulWidget {
  const TouchScaleWidget({
    super.key,
    required this.child,
    this.onTap,
    this.scaleValue = 0.90,
    this.duration = const Duration(milliseconds: 150),
  });

  final Widget child;
  final VoidCallback? onTap;
  final double scaleValue;
  final Duration duration;

  @override
  State<TouchScaleWidget> createState() => _TouchScaleWidgetState();
}

class _TouchScaleWidgetState extends State<TouchScaleWidget>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: widget.scaleValue).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: (_) => _handleTapDown(),
            onTapUp: (_) => _handleTapUp(),
            child: widget.child,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _handleTapDown() {
    _scaleController.forward();
  }

  void _handleTapUp() {
    _scaleController.reverse();
    widget.onTap?.call();
  }
}
