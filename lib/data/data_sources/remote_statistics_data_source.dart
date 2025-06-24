import 'package:dio/dio.dart';
import 'package:mongbi_app/core/secure_storage_service.dart';
import 'package:mongbi_app/data/data_sources/statistics_data_source.dart';
import 'package:mongbi_app/data/dtos/statistics_dto.dart';
import 'package:sentry_flutter/sentry_flutter.dart'; // ✅ Sentry 추가

class RemoteStatisticsDataSource implements StatisticsDataSource {
  RemoteStatisticsDataSource(this.dio);

  final Dio dio;

  final keyChanges = {
    '1': 'VERY_BAD',
    '2': 'BAD',
    '3': 'ORDINARY',
    '4': 'GOOD',
    '5': 'VERY_GOOD',
  };

  @override
  Future<StatisticsDto?> fetchMonthStatistics(DateTime dateTime) async {
    try {
      final userIndex = await SecureStorageService().getUserIdx();
      final year = dateTime.year;
      final month = dateTime.month.toString().padLeft(2, '0');

      final response = await dio.get('/dreams/statistics/monthly/$userIndex/$year/$month');

      if (response.data['code'] == 201 && response.data['success']) {
        final results = response.data['data'];
        _normalizeStatistics(results);
        return StatisticsDto.fromJson(results);
      } else {
        final error = Exception(response.data['message'] ?? '월간 통계 요청 실패');
        await Sentry.captureException(
          error,
          withScope: (scope) {
            scope.setExtra('userIndex', userIndex);
            scope.setExtra('type', 'month');
            scope.setExtra('year', year);
            scope.setExtra('month', month);
            scope.setExtra('response', response.data);
          },
        );
        return null;
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return null;
    }
  }

  @override
  Future<StatisticsDto?> fetchYearStatistics(DateTime dateTime) async {
    try {
      final userIndex = await SecureStorageService().getUserIdx();
      final year = dateTime.year.toString();

      final response = await dio.get('/dreams/statistics/year/$userIndex/$year');

      if (response.data['code'] == 201 && response.data['success']) {
        final results = response.data['data'];
        _normalizeStatistics(results);
        return StatisticsDto.fromJson(results);
      } else {
        final error = Exception(response.data['message'] ?? '연간 통계 요청 실패');
        await Sentry.captureException(
          error,
          withScope: (scope) {
            scope.setExtra('userIndex', userIndex);
            scope.setExtra('type', 'year');
            scope.setExtra('year', year);
            scope.setExtra('response', response.data);
          },
        );
        return null;
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return null;
    }
  }

  // ✅ 통계 공통 정규화 로직
  void _normalizeStatistics(Map<String, dynamic> results) {
    final distributionMap = results['DISTRIBUTION'];
    final moodStateMap = results['MOOD_STATE'];
    var keywordList = results['KEYWORDS'];

    // DISTRIBUTION 키 재매핑
    for (var oldKey in keyChanges.keys) {
      final value = distributionMap.remove(oldKey);
      if (value != null) {
        distributionMap[keyChanges[oldKey]!] = value;
      }
    }

    // MOOD_STATE 안의 키 재매핑
    moodStateMap.forEach((dreamType, innerMap) {
      for (var oldKey in keyChanges.keys) {
        if (innerMap.containsKey(oldKey)) {
          final value = innerMap.remove(oldKey);
          innerMap[keyChanges[oldKey]!] = value;
        }
      }
    });

    // 키워드 5개로 자르기
    if (keywordList.length > 5) {
      results['KEYWORDS'] = keywordList.sublist(0, 5);
    }
  }
}
