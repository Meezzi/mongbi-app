import 'package:flutter/material.dart';

class NoTransitionPage<T> extends Page<T> {
  const NoTransitionPage({
    required this.child,
    super.key,
  });
  final Widget child;
  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder<T>(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    );
  }
}