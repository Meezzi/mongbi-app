import 'package:dio/dio.dart';
import 'package:mongbi_app/data/data_sources/nickname_setting_data_source.dart';
import 'package:mongbi_app/data/dtos/user_dto.dart';

class RemoteNicknameSettingDataSource implements NicknameSettingDataSource {
  RemoteNicknameSettingDataSource(this.dio);
  final Dio dio;

  @override
  Future<UserDto> updateNickname({
    required int userId,
    required String nickname,
  }) async {
    final response = await dio.put(
      '/users/$userId/nickname',
      data: {'nickname': nickname},
    );

    if (response.statusCode == 200 && response.data['user'] != null) {
      return UserDto.fromJson(response.data['user']);
    } else {
      throw Exception('닉네임 수정 실패');
    }
  }
}
