import 'package:dio/dio.dart';
import 'package:mongbi_app/core/secure_storage_service.dart';
import 'package:mongbi_app/data/data_sources/alarm_data_source.dart';
import 'package:mongbi_app/data/dtos/alarm_dto.dart';

class RemoteAlarmDataSource implements AlarmDataSource {
  const RemoteAlarmDataSource(this.dio);

  final Dio dio;

  @override
  Future<List<AlarmDto>?> fetchAlarms() async {
    try {
      final userIndex = await SecureStorageService().getUserIdx();
      final response = await dio.get('/api/fcm-logs/user/$userIndex');

      if ((response.data['code'] == 201 || response.data['code'] == 200) &&
          response.data['success']) {
        final results = List.from(response.data['data']);
        final alarmDtoList = results.map((e) => AlarmDto.fromJson(e)).toList();
        return alarmDtoList;
      } else {
        throw Exception(response.data['message'] ?? '알 수 없는 오류가 발생하였습니다.');
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> updateIsReadStatus(int id) async {
    try {
      final response = await dio.put(
        '/api/fcm-logs/$id/read',
        data: {'isRead': true},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.data['code'] == 201 && response.data['success']) {
        return true;
      } else {
        throw Exception(response.data['message'] ?? '알 수 없는 오류가 발생하였습니다.');
      }
    } catch (e) {
      return false;
    }
  }
}
