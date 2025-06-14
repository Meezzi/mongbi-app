import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/core/get_responsive_ratio_by_width.dart';

class MonthYearPicker {
  OverlayEntry? _overlayEntry;

  void show(
    BuildContext context, {
    required double left,
    required double top,
    required ScrollController scrollController,
  }) {
    if (_overlayEntry != null) return; // 이미 띄워져 있으면 무시

    _overlayEntry = OverlayEntry(
      builder:
          (context) => DefaultTextStyle(
            style: TextStyle(),
            child: Stack(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    hide();
                  },
                  child: Container(color: Colors.transparent),
                ),
                Positioned(
                  left: getResponsiveRatioByWidth(context, left),
                  top: getResponsiveRatioByWidth(context, top),
                  child: Container(
                    padding: EdgeInsets.only(right: 12),
                    width: getResponsiveRatioByWidth(context, 100),
                    height: getResponsiveRatioByWidth(context, 189),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x337F2AE8),
                          offset: Offset(0, 4),
                          blurRadius: 10,
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: RawScrollbar(
                      controller: scrollController,
                      thumbVisibility: true,
                      thumbColor: Color(0xFFD6D4D8),
                      thickness: 6,
                      mainAxisMargin: 11,
                      crossAxisMargin: -8.5,
                      radius: Radius.circular(100),
                      child: ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        itemBuilder: (context, index) {
                          final month = index + 1;
                          final selectedMonth = DateTime.now().month;
                          final isActive = selectedMonth == month;

                          return GestureDetector(
                            onTap: () {
                              print('$month월 터치');
                              hide();
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                top: 8,
                                bottom: month == 12 ? 8 : 7,
                                left: 16,
                                right: 16,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    isActive
                                        ? Color(0xF5F5F4F5)
                                        : Colors.transparent,
                                border:
                                    month == 12
                                        ? null
                                        : Border(
                                          bottom: BorderSide(
                                            color: Color(0xF5F5F4F5),
                                          ),
                                        ),
                              ),
                              child: Text('$month월', style: Font.body14),
                            ),
                          );
                        },
                        itemCount: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
    );

    Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);
  }

  void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
