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

  void show(BuildContext context) {
    if (_overlayEntry != null) return; // 이미 띄워져 있으면 무시

    _overlayEntry = OverlayEntry(
      builder:
          (context) => DefaultTextStyle(
            style: TextStyle(),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(color: Color(0xB2000000)),
              child: Container(
                padding: const EdgeInsets.all(24),
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
                    descriptionWidget('행', '꿈 유형 (길몽, 일상몽, 악몽)'),
                    SizedBox(height: 16),
                    descriptionWidget('열', '기분상태 (기분 이모티콘의 색상으로 표현함)'),
                    SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        children: [
                          ...List.generate(iconPathList.length, (index) {
                            bool isLast = iconPathList.length == index + 1;

                            return Container(
                              padding:
                                  isLast
                                      ? null
                                      : const EdgeInsets.only(right: 4),
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
                    descriptionWidget('칸', '기분 상태 빈도 (짙을수록 많이 해당됨)'),
                    SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Row(
                        children: [
                          frequencyWidget('1~2회', Color(0xFFDBBEFF)),
                          SizedBox(width: 4),
                          frequencyWidget('3~4회', Color(0xFFB273FF)),
                          SizedBox(width: 4),
                          frequencyWidget('5~6회', Color(0xFF8C2EFF)),
                          SizedBox(width: 4),
                          frequencyWidget('7~8회', Color(0xFF6321B5)),
                          SizedBox(width: 4),
                          frequencyWidget('9회~', Color(0xFF3B136B)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );

    Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);
  }

  void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  Widget frequencyWidget(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: Font.body12.copyWith(
          color: text == '1~2회' ? null : Colors.white,
        ),
      ),
    );
  }

  Widget descriptionWidget(String label, String content) {
    return Row(
      children: [
        Text(label, style: Font.subTitle14),
        SizedBox(width: 4),
        Text(content, style: Font.body14),
      ],
    );
  }
}
