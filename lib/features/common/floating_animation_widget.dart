import 'package:flutter/material.dart';

class FloatingAnimationWidget extends StatefulWidget {
  const FloatingAnimationWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1400),
    this.offset = const Offset(0, -0.02),
  });

  final Widget child;
  final Duration duration;
  final Offset offset;

  @override
  State<FloatingAnimationWidget> createState() =>
      _FloatingAnimationWidgetState();
}

class _FloatingAnimationWidgetState extends State<FloatingAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);

    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: widget.offset,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: _animation, child: widget.child);
  }
}
