import 'package:dio/dio.dart';
import 'package:mongbi_app/core/secure_storage_service.dart';
import 'package:mongbi_app/data/data_sources/statistics_data_source.dart';
import 'package:mongbi_app/data/dtos/statistics_dto.dart';

class RemoteStatisticsDataSource implements StatisticsDataSource {
  RemoteStatisticsDataSource(this.dio);

  Dio dio;
  int userIndex = 41;

  @override
  Future<StatisticsDto?> fetchMonthStatistics(DateTime dateTime) async {
    try {
      final year = dateTime.year;
      final month =
          dateTime.month.toString().length < 2
              ? dateTime.month.toString().padLeft(2, '0')
              : dateTime.month;

      Map<String, String> keyChanges = {
        '1': 'VERY_BAD',
        '2': 'BAD',
        '3': 'ORDINARY',
        '4': 'GOOD',
        '5': 'VERY_GOOD',
      };
      final response = await dio.get(
        '/dreams/statistics/monthly/$userIndex/$year/$month',
      );

      if (response.data['code'] == 201 && response.data['success']) {
        final results = response.data['data'];
        final distributionMap = results['DISTRIBUTION'];
        final moodStateMap = results['MOOD_STATE'];
        var keywordList = results['KEYWORDS'];

        // results['DISTRIBUTION']의 key의 이름만 변경
        // results['DISTRIBUTION']['1'] => results['DISTRIBUTION']['VERY_BAD']
        for (var oldKey in keyChanges.keys) {
          var value = distributionMap[oldKey];
          distributionMap.remove(oldKey);
          distributionMap[keyChanges[oldKey]!] = value;
        }

        // results['MOOD_STATE']의 'GOOD_DREAM'의 key의 이름만 변경
        // results['MOOD_STATE']['GOOD_DREAM']['1'] => results['MOOD_STATE']['GOOD_DREAM']['VERY_BAD']
        for (var dreamType in moodStateMap.keys) {
          var distributionMap = moodStateMap[dreamType]!;

          for (var oldKey in keyChanges.keys) {
            if (distributionMap.containsKey(oldKey)) {
              var value = distributionMap[oldKey];
              distributionMap.remove(oldKey);
              distributionMap[keyChanges[oldKey]!] = value!;
            }
          }
        }

        // 심리 분석 키워드 5개로 제한
        if (keywordList.length > 5) {
          results['KEYWORDS'] = keywordList.sublist(0, 5);
        }

        final statisticsDto = StatisticsDto.fromJson(results);
        return statisticsDto;
      } else {
        throw Exception(response.data['message'] ?? '알 수 없는 오류가 발생하였습니다.');
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<StatisticsDto?> fetchYearStatistics(DateTime dateTime) async {
    try {
      final year = dateTime.year.toString();
      Map<String, String> keyChanges = {
        '1': 'VERY_BAD',
        '2': 'BAD',
        '3': 'ORDINARY',
        '4': 'GOOD',
        '5': 'VERY_GOOD',
      };

      // TODO : userIdx로 변경하기
      // TODO : idToken 유저 엔티티에서 받아오기
      final response = await dio.get(
        '/dreams/statistics/year/$userIndex/$year',
      );

      if (response.data['code'] == 201 && response.data['success']) {
        final results = response.data['data'];
        final distributionMap = results['DISTRIBUTION'];
        final moodStateMap = results['MOOD_STATE'];
        var keywordList = results['KEYWORDS'];

        // results['DISTRIBUTION']의 key의 이름만 변경
        // results['DISTRIBUTION']['1'] => results['DISTRIBUTION']['VERY_BAD']
        for (var oldKey in keyChanges.keys) {
          var value = distributionMap[oldKey];
          distributionMap.remove(oldKey);
          distributionMap[keyChanges[oldKey]!] = value;
        }

        // results['MOOD_STATE']의 'GOOD_DREAM'의 key의 이름만 변경
        // results['MOOD_STATE']['GOOD_DREAM']['1'] => results['MOOD_STATE']['GOOD_DREAM']['VERY_BAD']
        for (var dreamType in moodStateMap.keys) {
          var distributionMap = moodStateMap[dreamType]!;

          for (var oldKey in keyChanges.keys) {
            if (distributionMap.containsKey(oldKey)) {
              var value = distributionMap[oldKey];
              distributionMap.remove(oldKey);
              distributionMap[keyChanges[oldKey]!] = value!;
            }
          }
        }

        // 심리 분석 키워드 5개로 제한
        if (keywordList.length > 5) {
          results['KEYWORDS'] = keywordList.sublist(0, 5);
        }

        final statisticsDto = StatisticsDto.fromJson(results);
        return statisticsDto;
      } else {
        throw Exception(response.data['message'] ?? '알 수 없는 오류가 발생하였습니다.');
      }
    } catch (e) {
      return null;
    }
  }
}
