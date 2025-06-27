import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mongbi_app/core/font.dart';

class MoodStateInfoModal {
  OverlayEntry? _overlayEntry;

  final iconPathList = [
    'assets/icons/very_bad.svg',
    'assets/icons/bad.svg',
    'assets/icons/ordinary.svg',
    'assets/icons/good.svg',
    'assets/icons/very_good.svg',
  ];

  final monthFrequencyList = ['1~2회', '3~4회', '5~6회', '7~8회', '9회~'];
  final yearFrequencyList = ['1~10회', '11~20회', '21~30회', '31~40회', '41회~'];
  final colorList = [
    Color(0xFFDBBEFF),
    Color(0xFFB273FF),
    Color(0xFF8C2EFF),
    Color(0xFF6321B5),
    Color(0xFF3B136B),
  ];

  void show({required BuildContext context, required bool isMonth}) {
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
                  child: Container(color: Color(0xB2000000)),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFFFAFAFA),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('꿈 유형별 기분 상태', style: Font.title14),
                            GestureDetector(
                              onTap: () {
                                hide();
                              },
                              child: SvgPicture.asset(
                                'assets/icons/cancel.svg',
                                fit: BoxFit.cover,
                                width: 20,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        _descriptionWidget(
                          context: context,
                          label: '행',
                          content: '꿈 유형 (길몽, 일상몽, 악몽)',
                        ),
                        SizedBox(height: 16),
                        _descriptionWidget(
                          context: context,
                          label: '열',
                          content: '기분상태 (기분 이모티콘의 색상으로 표현함)',
                        ),
                        SizedBox(height: 6),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          child: Row(
                            children: [
                              ...List.generate(iconPathList.length, (index) {
                                bool isLast = iconPathList.length == index + 1;

                                return Container(
                                  padding:
                                      isLast ? null : EdgeInsets.only(right: 4),
                                  child: SvgPicture.asset(
                                    iconPathList[index],
                                    fit: BoxFit.cover,
                                    width: 20,
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        _descriptionWidget(
                          context: context,
                          label: '칸',
                          content: '기분 상태 빈도 (짙을수록 많이 해당됨)',
                        ),
                        SizedBox(height: 6),
                        Padding(
                          padding: EdgeInsets.only(left: 18),
                          child: Row(
                            children: [
                              ...List.generate(5, (index) {
                                bool isList = 5 == index + 1;

                                return _frequencyWidget(
                                  context: context,
                                  text:
                                      isMonth
                                          ? monthFrequencyList[index]
                                          : yearFrequencyList[index],
                                  color: colorList[index],
                                  isLast: isList,
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
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

  Widget _frequencyWidget({
    required BuildContext context,
    required String text,
    required Color color,
    required bool isLast,
  }) {
    return Container(
      margin: isLast ? null : EdgeInsets.only(right: 4),
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: Font.body12.copyWith(
          color: text == '1~2회' || text == '1~10회' ? null : Colors.white,
        ),
      ),
    );
  }

  Widget _descriptionWidget({
    required BuildContext context,
    required String label,
    required String content,
  }) {
    return Row(
      children: [
        Text(label, style: Font.subTitle14),
        SizedBox(width: 4),
        Text(content, style: Font.body14),
      ],
    );
  }
}
