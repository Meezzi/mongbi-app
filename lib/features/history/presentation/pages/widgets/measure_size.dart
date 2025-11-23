import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef OnWidgetSizeChange = void Function(Size? size);

/// 자식 위젯의 크기 변동을 감지하기 위한 위젯
class MeasureSize extends StatefulWidget {
  const MeasureSize({
    super.key,
    required this.child,
    this.onStop,
    this.onChange,
    this.debounceDuration = const Duration(milliseconds: 100),
  });

  final OnWidgetSizeChange? onChange;
  final VoidCallback? onStop;
  final Widget child;
  final Duration debounceDuration;

  @override
  State<MeasureSize> createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<MeasureSize> {
  Size? _oldSize;
  Timer? _debounceTimer;

  void _handleSizeChanged(Size? newSize) {
    if (_oldSize == newSize) return;
    _oldSize = newSize;
    widget.onChange?.call(newSize);

    // 디바운스 타이머 리셋
    _debounceTimer?.cancel();
    if (widget.onStop != null) {
      _debounceTimer = Timer(widget.debounceDuration, () {
        widget.onStop!();
      });
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MeasureSizeRenderObjectWidget(
      onChange: _handleSizeChanged,
      child: widget.child,
    );
  }
}

// 기존 MeasureSize의 RenderObject 부분을 별도 위젯으로 분리
class MeasureSizeRenderObjectWidget extends SingleChildRenderObjectWidget {
  const MeasureSizeRenderObjectWidget({
    super.key,
    required Widget super.child,
    this.onChange,
  });

  final OnWidgetSizeChange? onChange;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderMeasureSize(onChange);
  }
}

class RenderMeasureSize extends RenderProxyBox {
  RenderMeasureSize(this.onChange);

  Size? oldSize;
  final OnWidgetSizeChange? onChange;

  @override
  void performLayout() {
    super.performLayout();
    Size? newSize = child?.size;
    if (oldSize == newSize) return;
    oldSize = newSize;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onChange?.call(newSize);
    });
  }
}
