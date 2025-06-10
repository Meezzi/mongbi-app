import 'package:flutter/material.dart';

double getResponsiveRatioByWidth(BuildContext context, double value) {
  final deviceSize = MediaQuery.of(context).size;
  return (value / deviceSize.width) * deviceSize.width;
}
