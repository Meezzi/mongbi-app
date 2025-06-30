import 'dart:math';

import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsHelper {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  static Future<void> logEvent(String name, Map<String, Object> parameters) async {
    // 파라미터 값의 길이를 100자로 제한합니다.
    final sanitizedParameters = parameters.map((key, value) {
      if (value is String) {
        return MapEntry(key, value.substring(0, min(value.length, 100)));
      }
      return MapEntry(key, value);
    });
    await _analytics.logEvent(name: name, parameters: sanitizedParameters);
  }

  static Future<void> logButtonClick(String buttonName, String screenName) async {
    await logEvent('버튼_클릭', {
      '버튼_이름': buttonName,
      '화면_이름': screenName,
    });
  }

  static Future<void> logLogin(String provider, String screenName) async {
    await logEvent('로그인_성공', {
      '로그인_수단': provider,
      '화면_이름': screenName,
    });
  }

  static Future<void> logLoginFailure(String provider, String screenName, String error) async {
    await logEvent('로그인_실패', {
      '로그in_수단': provider,
      '화면_이름': screenName,
      '에러_메시지': error,
    });
  }

  static Future<void> logScreenView(String screenName) async {
    await _analytics.logScreenView(screenName: screenName);
  }
}
