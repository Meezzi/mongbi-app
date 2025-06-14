import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/core/get_responsive_ratio_by_width.dart';

class MonthYearPicker {
  OverlayEntry? _overlayEntry;

  void show(
    BuildContext context, {
    required bool isMonth,
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
                        itemCount: isMonth ? 12 : 6,
                        itemBuilder: (context, index) {
                          if (isMonth) {
                            final month = index + 1;
                            // TODO : 선택된 월로 할당하기
                            final selectedMonth = DateTime.now().month;
                            final isActive = selectedMonth == month;
                            final isLast = 12 - 1 == index;
                            return pickerContent(
                              content: '$month월',
                              isActive: isActive,
                              isLast: isLast,
                            );
                          } else {
                            final currntYear = DateTime.now().year;
                            final year = currntYear - (5 - index);
                            // TODO : 선택된 년으로 할당하기
                            final selectedYear = DateTime.now().year;
                            final isActive = selectedYear == year;
                            final isLast = 6 - 1 == index;
                            return pickerContent(
                              content: '$year년',
                              isActive: isActive,
                              isLast: isLast,
                            );
                          }
                        },
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

  Widget pickerContent({
    required String content,
    required isActive,
    required isLast,
  }) {
    return GestureDetector(
      onTap: () {
        print('$content 터치');
        hide();
      },
      child: Container(
        padding: EdgeInsets.only(
          top: 8,
          bottom: isLast ? 8 : 7,
          left: 16,
          right: 16,
        ),
        decoration: BoxDecoration(
          color: isActive ? Color(0xF5F5F4F5) : Colors.transparent,
          border:
              isLast
                  ? null
                  : Border(bottom: BorderSide(color: Color(0xF5F5F4F5))),
        ),
        child: Text(content, style: Font.body14),
      ),
    );
  }
}
