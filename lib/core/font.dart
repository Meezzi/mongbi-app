import 'package:flutter/material.dart';

/// 공통된 폰트 스타일 정의
class Font {
  // 기본 색상
  static final defaultColor = Color(0xff1A181B);

  // body - Regular
  static final body12 = TextStyle(
    color: defaultColor,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 16 / 12,
  );
  static final body14 = TextStyle(
    color: defaultColor,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 20 / 14,
  );
  static final body16 = TextStyle(
    color: defaultColor,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 24 / 16,
  );
  static final body18 = TextStyle(
    color: defaultColor,
    fontWeight: FontWeight.w400,
    fontSize: 18,
    height: 24 / 18,
  );

  // subTitle - bold
  static final subTitle12 = TextStyle(
    color: defaultColor,
    fontWeight: FontWeight.w700,
    fontSize: 12,
    height: 16 / 12,
  );
  static final subTitle14 = TextStyle(
    color: defaultColor,
    fontWeight: FontWeight.w700,
    fontSize: 14,
    height: 20 / 14,
  );
  static final subTitle16 = TextStyle(
    color: defaultColor,
    fontWeight: FontWeight.w700,
    fontSize: 16,
    height: 24 / 16,
  );
  static final subTitle18 = TextStyle(
    color: defaultColor,
    fontWeight: FontWeight.w700,
    fontSize: 18,
    height: 24 / 18,
  );

  // title - extra bold
  static final title14 = TextStyle(
    color: defaultColor,
    fontWeight: FontWeight.w800,
    fontSize: 14,
    height: 20 / 14,
  );
  static final title16 = TextStyle(
    color: defaultColor,
    fontWeight: FontWeight.w800,
    fontSize: 16,
    height: 24 / 16,
  );
  static final title18 = TextStyle(
    color: defaultColor,
    fontWeight: FontWeight.w800,
    fontSize: 18,
    height: 24 / 18,
  );
  static final title20 = TextStyle(
    color: defaultColor,
    fontWeight: FontWeight.w800,
    fontSize: 20,
    height: 28 / 20,
  );
  static final title24 = TextStyle(
    color: defaultColor,
    fontWeight: FontWeight.w800,
    fontSize: 24,
    height: 32 / 24,
  );
  static final title32 = TextStyle(
    color: defaultColor,
    fontWeight: FontWeight.w800,
    fontSize: 32,
    height: 36 / 32,
  );
}
