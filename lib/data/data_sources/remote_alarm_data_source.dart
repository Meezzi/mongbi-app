import 'package:dio/dio.dart';
import 'package:mongbi_app/data/data_sources/alarm_data_source.dart';
import 'package:mongbi_app/data/dtos/alarm_dto.dart';

class RemoteAlarmDataSource implements AlarmDataSource {
  RemoteAlarmDataSource(this.dio);

  Dio dio;

  @override
  Future<List<AlarmDto>?> fetchAlarms() async {
    try {
      // TODO : userIdx로 변경하기
      // TODO : idToken 유저 엔티티에서 받아오기
      final response = await dio.get('/alarm/');

      if (response.data['code'] == 201 && response.data['success']) {
        final results = List.from(response.data['data']);
        final alarmDtoList = results.map((e) => AlarmDto.fromJson(e)).toList();
        return alarmDtoList;
      } else {
        throw Exception(response.data['message'] ?? '알 수 없는 오류가 발생하였습니다.');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? '네트워크 오류가 발생하였습니다.');
    } catch (e) {
      return null;
    }
  }
}
