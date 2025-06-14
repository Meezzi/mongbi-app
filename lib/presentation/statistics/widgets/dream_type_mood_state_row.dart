import 'package:flutter/material.dart';
import 'package:mongbi_app/core/font.dart';
import 'package:mongbi_app/core/get_responsive_ratio_by_width.dart';

class DreamTypeMoodStateRow extends StatelessWidget {
  const DreamTypeMoodStateRow({
    super.key,
    this.label,
    this.isMonth = true,
    this.veryBad = 0,
    this.bad = 0,
    this.ordinary = 0,
    this.good = 0,
    this.veryGood = 0,
  });

  final String? label;
  final bool isMonth;
  final int veryBad;
  final int bad;
  final int ordinary;
  final int good;
  final int veryGood;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 라벨
        Expanded(
          flex: 825,
          child:
              _isString(label)
                  ? Center(
                    child: Text(
                      label!,
                      style: Font.subTitle12.copyWith(
                        fontSize: getResponsiveRatioByWidth(context, 12),
                      ),
                    ),
                  )
                  : SizedBox(),
        ),
        SizedBox(width: 8),
        // very bad 상태
        Expanded(
          flex: 1000,
          child: Container(
            height:
                _isString(label)
                    ? getResponsiveRatioByWidth(context, 24)
                    : getResponsiveRatioByWidth(context, 16),
            decoration: BoxDecoration(
              color:
                  _isString(label)
                      ? _getCountColor(isMonth: isMonth, count: veryBad)
                      : Color(0xFFEF54A9),
              borderRadius: _isString(label) ? BorderRadius.circular(4) : null,
              shape: _isString(label) ? BoxShape.rectangle : BoxShape.circle,
            ),
          ),
        ),
        SizedBox(width: 8),
        // bad 상태
        Expanded(
          flex: 1000,
          child: Container(
            height:
                _isString(label)
                    ? getResponsiveRatioByWidth(context, 24)
                    : getResponsiveRatioByWidth(context, 16),
            decoration: BoxDecoration(
              color:
                  _isString(label)
                      ? _getCountColor(isMonth: isMonth, count: bad)
                      : Color(0xFF8C2EFF),
              borderRadius: _isString(label) ? BorderRadius.circular(4) : null,
              shape: _isString(label) ? BoxShape.rectangle : BoxShape.circle,
            ),
          ),
        ),
        SizedBox(width: 8),
        // ordinary 상태
        Expanded(
          flex: 1000,
          child: Container(
            height:
                _isString(label)
                    ? getResponsiveRatioByWidth(context, 24)
                    : getResponsiveRatioByWidth(context, 16),
            decoration: BoxDecoration(
              color:
                  _isString(label)
                      ? _getCountColor(isMonth: isMonth, count: ordinary)
                      : Color(0xFF2E5CE6),
              borderRadius: _isString(label) ? BorderRadius.circular(4) : null,
              shape: _isString(label) ? BoxShape.rectangle : BoxShape.circle,
            ),
          ),
        ),
        SizedBox(width: 8),
        // good 상태
        Expanded(
          flex: 1000,
          child: Container(
            height:
                _isString(label)
                    ? getResponsiveRatioByWidth(context, 24)
                    : getResponsiveRatioByWidth(context, 16),
            decoration: BoxDecoration(
              color:
                  _isString(label)
                      ? _getCountColor(isMonth: isMonth, count: good)
                      : Color(0xFF45CCBC),
              borderRadius: _isString(label) ? BorderRadius.circular(4) : null,
              shape: _isString(label) ? BoxShape.rectangle : BoxShape.circle,
            ),
          ),
        ),
        SizedBox(width: 8),
        // very good 상태
        Expanded(
          flex: 1000,
          child: Container(
            height:
                _isString(label)
                    ? getResponsiveRatioByWidth(context, 24)
                    : getResponsiveRatioByWidth(context, 16),
            decoration: BoxDecoration(
              color:
                  _isString(label)
                      ? _getCountColor(isMonth: isMonth, count: veryGood)
                      : Color(0xFF79E4F9),
              borderRadius: _isString(label) ? BorderRadius.circular(4) : null,
              shape: _isString(label) ? BoxShape.rectangle : BoxShape.circle,
            ),
          ),
        ),
        SizedBox(width: 8),
      ],
    );
  }

  /// 라벨이 있는지 여부
  bool _isString(String? label) {
    return label is String;
  }

  /// 횟수에 따라 색상 반환
  Color _getCountColor({required bool isMonth, required int count}) {
    if (isMonth) {
      if (count >= 9) {
        return Color(0xFF3B136B);
      } else if (count >= 7) {
        return Color(0xFF6321B5);
      } else if (count >= 5) {
        return Color(0xFF8C2EFF);
      } else if (count >= 3) {
        return Color(0xFFB273FF);
      } else if (count >= 1) {
        return Color(0xFFDBBEFF);
      } else {
        return Color(0xF5F5F4F5);
      }
    } else {
      if (count >= 41) {
        return Color(0xFF3B136B);
      } else if (count >= 31) {
        return Color(0xFF6321B5);
      } else if (count >= 21) {
        return Color(0xFF8C2EFF);
      } else if (count >= 11) {
        return Color(0xFFB273FF);
      } else if (count >= 1) {
        return Color(0xFFDBBEFF);
      } else {
        return Color(0xF5F5F4F5);
      }
    }
  }
}
