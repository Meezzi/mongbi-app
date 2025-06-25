import 'package:dio/dio.dart';
import 'package:mongbi_app/core/secure_storage_service.dart';
import 'package:mongbi_app/data/data_sources/user_info_data_source.dart';
import 'package:mongbi_app/data/dtos/user_dto.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class RemoteUserInfoGetDataSource implements GetUserInfoDataSource {
  RemoteUserInfoGetDataSource(this.dio);
  final Dio dio;

  @override
  Future<List<UserDto>> fetchGetUserInfo() async {
    try {
      final userId = await SecureStorageService().getUserIdx();
      final response = await dio.get('/users/$userId');

      if (response.statusCode == 200 && response.data != null) {
        final userDto = UserDto.fromJson(response.data);
        return [userDto];
      } else {
        final error = Exception(response.data['message'] ?? '사용자 정보 조회 실패');
        await Sentry.captureException(
          error,
          withScope: (scope) {
            scope.setTag('api', 'get_user_info');
            scope.setExtra('userId', userId);
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
          scope.setTag('api', 'get_user_info');
        },
      );
      throw Exception('사용자 정보를 가져오는 중 오류가 발생했습니다.');
    }
  }
}
