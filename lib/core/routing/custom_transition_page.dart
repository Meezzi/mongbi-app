import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage<T> buildFadeTransitionPage<T>({
  required Widget child,
  required LocalKey key,
  Duration duration = const Duration(milliseconds: 500),
}) {
  return CustomTransitionPage<T>(
    key: key,
    child: child,
    transitionDuration: duration,
    transitionsBuilder: (
      context,
      animation,
      secondaryAnimation,
      child,
    ) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      );
      return FadeTransition(opacity: curved, child: child);
    },
  );
}
