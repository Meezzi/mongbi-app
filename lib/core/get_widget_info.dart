import 'package:flutter/material.dart';

RenderBox? getWidgetInfo(GlobalKey key) {
  final widgetContext = key.currentContext;
  if (widgetContext != null) {
    return widgetContext.findRenderObject() as RenderBox;
  }
  return null;
}
