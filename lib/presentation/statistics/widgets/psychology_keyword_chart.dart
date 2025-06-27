import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/data/dtos/statistics_dto.dart';
import 'package:mongbi_app/presentation/statistics/widgets/common_box.dart';
import 'package:mongbi_app/presentation/statistics/widgets/custom_fl_dot_painter.dart';

class PsychologyKeywordChart extends StatelessWidget {
  const PsychologyKeywordChart({
    super.key,
    required this.isFirst,
    required this.keywordList,
  });

  final bool isFirst;
  final List<Keyword> keywordList;

  @override
  Widget build(BuildContext context) {
    final kwLength = keywordList.length;
    final List<double> xList = [
      kwLength == 1 ? 5 : 3.5,
      kwLength == 2 ? 6.8 : 7.2,
      kwLength == 3 ? 3.9 : 2.5,
      5.4,
      7,
    ];
    final List<double> yList = [
      kwLength == 1 ? 5 : 6.8,
      kwLength == 2 ? 3.5 : 4.4,
      kwLength == 3 ? 2 : 3,
      1.3,
      7.5,
    ];
    final List<double> radiusList = [68, 52, 44, 44, 36];
    final List<Color> colorList = [
      Color(0xFF7F2AE8),
      Color(0xFF15AE9C),
      Color(0xFFB273FF),
      Color(0xFF45CCBC),
      Color(0xFFF4EAFF),
    ];
    final List<TextStyle> textStyleList = [
      TextStyle(
        fontFamily: 'NanumSquareRound',
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 16,
        height: 24 / 16,
      ),
      TextStyle(
        fontFamily: 'NanumSquareRound',
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 14,
        height: 20 / 14,
      ),
      TextStyle(
        fontFamily: 'NanumSquareRound',
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 12,
        height: 16 / 12,
      ),
      TextStyle(
        fontFamily: 'NanumSquareRound',
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 12,
        height: 16 / 12,
      ),
      TextStyle(
        fontFamily: 'NanumSquareRound',
        color: isFirst ? Color(0xFFFFFFFF) : Color(0xFFCA9FFF),
        fontWeight: FontWeight.w700,
        fontSize: 12,
        height: 16 / 12,
      ),
    ];
    final List<String> initialKeywordList = [
      '새로운 시작',
      '큰 기대감',
      '자신감',
      '성장욕구',
      '설렘',
    ];

    return CommonBox(
      applyBottomPadding: false,
      title: Text('몽비가 분석해준 심리 키워드', style: Font.title14),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: SizedBox(
            width: double.maxFinite,
            height: 308,
            child: ScatterChart(
              ScatterChartData(
                // 자체적으로 Positioned처럼 동작
                // 인덱스가 클수록 다른 위젯 위에 쌓일 수 있다
                scatterSpots: List.generate(isFirst ? 5 : kwLength, (index) {
                  return ScatterSpot(
                    xList[index],
                    yList[index],
                    dotPainter: CustomFlDotPainter(
                      radius: radiusList[index],
                      color: isFirst ? Color(0xFFD6D4D8) : colorList[index],
                      text:
                          isFirst
                              ? initialKeywordList[index]
                              : keywordList[index].keyword,
                      textStyle: textStyleList[index],
                    ),
                  );
                }),
                scatterTouchData: ScatterTouchData(
                  // 꾹 터치 시 값을 볼 수 있음
                  enabled: false,
                ),
                gridData: FlGridData(show: false), // 격자
                borderData: FlBorderData(show: false), // 테두리
                titlesData: FlTitlesData(
                  show: false, // 모든 축 라벨 보이기 여부
                  // 각 축 별로 라벨 보이기 여부를 설정할 수 있음
                ),
                minX: 0,
                maxX: 10,
                minY: 0,
                maxY: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
