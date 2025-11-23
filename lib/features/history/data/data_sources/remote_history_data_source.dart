import 'package:dio/dio.dart';
import 'package:mongbi_app/core/secure_storage_service.dart';
import 'package:mongbi_app/features/history/data/data_sources/history_data_source.dart';
import 'package:mongbi_app/features/history/data/dtos/history_dto.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class RemoteHistoryDataSource implements HistoryDataSource {
  RemoteHistoryDataSource(this._dio, this._secureStorageService);

  final Dio _dio;
  final SecureStorageService _secureStorageService;

  @override
  Future<List<HistoryDto>> feachUserDreamsHistory() async {
    try {
      final userIndex = await _secureStorageService.getUserIdx();
      final response = await _dio.get('/dreams/$userIndex');

      if (response.data['code'] == 201 && response.data['success']) {
        final results = List.from(response.data['data']);
        final historyDtoList =
            results.map((e) => HistoryDto.fromJson(e)).toList();
        return historyDtoList;
      } else {
        final error = Exception(
          response.data['message'] ?? '알 수 없는 오류가 발생하였습니다.',
        );
        await Sentry.captureException(
          error,
          withScope: (scope) {
            scope.setExtra('userIndex', userIndex);
            scope.setExtra('response', response.data);
          },
        );
        throw error;
      }
    } catch (e, s) {
      await Sentry.captureException(
        e,
        stackTrace: s,
        withScope: (scope) {
          scope.setTag('function', 'feachUserDreamsHistory');
        },
      );
      return [];
    }
  }
}
