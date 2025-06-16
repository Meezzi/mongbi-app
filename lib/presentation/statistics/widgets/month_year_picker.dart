import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/core/get_responsive_ratio_by_width.dart';
import 'package:mongbi_app/providers/statistics_provider.dart';

class MonthYearPicker extends ConsumerStatefulWidget {
  const MonthYearPicker({
    super.key,
    required this.isMonth,
    required this.left,
    required this.top,
    required this.scrollController,
  });

  final bool isMonth;
  final double left;
  final double top;
  final ScrollController scrollController;

  @override
  ConsumerState<MonthYearPicker> createState() => MonthYearPickerState();
}

class MonthYearPickerState extends ConsumerState<MonthYearPicker> {
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    hide();
    super.dispose();
  }

  void show() {
    if (_overlayEntry != null) return; // 이미 띄워져 있으면 무시

    _overlayEntry = OverlayEntry(
      builder:
          (context) => DefaultTextStyle(
            style: const TextStyle(),
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
                  left: widget.left,
                  top: widget.top,
                  child: Container(
                    padding: const EdgeInsets.only(right: 12),
                    width: getResponsiveRatioByWidth(context, 100),
                    height: getResponsiveRatioByWidth(context, 189),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x337F2AE8),
                          offset: const Offset(0, 4),
                          blurRadius: 10,
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: RawScrollbar(
                      thumbColor: const Color(0xFFD6D4D8),
                      crossAxisMargin: -8.5,
                      radius: const Radius.circular(100),
                      child: ListView.builder(
                        controller: widget.scrollController,
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        itemCount: widget.isMonth ? 12 : 6,
                        itemBuilder: (context, index) {
                          if (widget.isMonth) {
                            final month = index + 1;
                            final focusedMonth =
                                ref
                                    .read(pickerViewModelProvider)
                                    .focusedMonth
                                    .month;
                            final isActive = focusedMonth == month;
                            final isLast = 12 - 1 == index;
                            return pickerContent(
                              context: context,
                              content: '$month월',
                              isActive: isActive,
                              isLast: isLast,
                              onTap: () {
                                final pickerVm = ref.read(
                                  pickerViewModelProvider.notifier,
                                );
                                pickerVm.onChangedMonth(
                                  DateTime(DateTime.now().year, month),
                                );
                                hide();
                              },
                            );
                          } else {
                            final currentYear = DateTime.now().year;
                            final year = currentYear - (5 - index);
                            final focusedMonth =
                                ref
                                    .read(pickerViewModelProvider)
                                    .focusedYear
                                    .year;

                            final isActive = focusedMonth == year;
                            final isLast = 6 - 1 == index;
                            return pickerContent(
                              context: context,
                              content: '$year년',
                              isActive: isActive,
                              isLast: isLast,
                              onTap: () {
                                final pickerVm = ref.read(
                                  pickerViewModelProvider.notifier,
                                );
                                pickerVm.onChangedYear(DateTime(year));
                                hide();
                              },
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
    required BuildContext context,
    required String content,
    required bool isActive,
    required bool isLast,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(
          top: getResponsiveRatioByWidth(context, 8),
          bottom:
              isLast
                  ? getResponsiveRatioByWidth(context, 8)
                  : getResponsiveRatioByWidth(context, 7),
          left: getResponsiveRatioByWidth(context, 16),
          right: getResponsiveRatioByWidth(context, 16),
        ),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xF5F5F4F5) : Colors.transparent,
          border:
              isLast
                  ? null
                  : const Border(bottom: BorderSide(color: Color(0xF5F5F4F5))),
        ),
        child: Text(
          content,
          style: Font.body14.copyWith(
            fontSize: getResponsiveRatioByWidth(context, 14),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // show()를 호출해야 picker가 뜸
    return const SizedBox.shrink();
  }
}
