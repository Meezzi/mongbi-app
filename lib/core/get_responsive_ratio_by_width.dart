import 'package:flutter/material.dart';

double getResponsiveRatioByWidth(
  BuildContext context,
  double value, {
  int standardWidth = 375,
}) {
  final deviceSize = MediaQuery.of(context).size;

  return (deviceSize.width / standardWidth) * value;
}