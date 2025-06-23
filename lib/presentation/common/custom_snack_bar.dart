import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';

SnackBar customSnackBar(String message) {
  return SnackBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(bottom: 80),
    duration: Duration(seconds: 2),
    content: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: ShapeDecoration(
            color: Color(0xFFEA4D57).withValues(alpha: 0.9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
            shadows: [
              BoxShadow(
                color: Color(0xFF1A181B).withValues(alpha: 0.1),
                blurRadius: 10,
                offset: Offset(2, 2),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: Font.title14.copyWith(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
