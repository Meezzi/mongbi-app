import 'package:dio/dio.dart';
import 'package:mongbi_app/data/data_sources/nickname_setting_data_source.dart';
import 'package:mongbi_app/data/dtos/user_dto.dart';
import 'package:sentry_flutter/sentry_flutter.dart'; // ✅ Sentry 추가

class RemoteNicknameSettingDataSource implements NicknameSettingDataSource {
  RemoteNicknameSettingDataSource(this.dio);
  final Dio dio;

  @override
  Future<UserDto> updateNickname({
    required int userId,
    required String nickname,
  }) async {
    try {
      final response = await dio.put(
        '/users/$userId/nickname',
        data: {'nickname': nickname},
      );

      if (response.statusCode == 200 && response.data['user'] != null) {
        return UserDto.fromJson(response.data['user']);
      } else {
        final error = Exception('닉네임 수정 실패: 응답에 user가 없습니다.');
        await Sentry.captureException(
          error,
          withScope: (scope) {
            scope.setExtra('userId', userId);
            scope.setExtra('nickname', nickname);
            scope.setExtra('response', response.data);
          },
        );
        throw error;
      }
    } on DioException catch (e, s) {
      await Sentry.captureException(
        e,
        stackTrace: s,
        withScope: (scope) {
          scope.setTag('api', 'nickname_update');
          scope.setExtra('userId', userId);
          scope.setExtra('nickname', nickname);
        },
      );
      throw Exception(e.message ?? '네트워크 오류로 닉네임 수정에 실패했습니다.');
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      throw Exception('닉네임 수정 중 알 수 없는 오류 발생: $e');
    }
  }
}
