import 'package:dio/dio.dart';
import 'package:mongbi_app/data/data_sources/nickname_setting_data_source.dart';
import 'package:mongbi_app/data/dtos/user_dto.dart';

class NickNameSettingDataSourceImpl implements NickNameSettingDataSource {
  NickNameSettingDataSourceImpl(this.dio);
  final Dio dio;

  @override
  Future<UserDto> nickNameSetting({
    required int userId,
    required String nickname,
  }) async {
    final response = await dio.put(
      '/users/$userId/nickname',
      data: {'nickname': nickname},
      options: Options(
        validateStatus: (_) => true, // ✅ 200이 아니어도 print는 실행됨
      ),
    );
    
    if (response.statusCode == 200 && response.data['user'] != null) {
      return UserDto.fromJson(response.data['user']);
    } else {
      throw Exception('닉네임 수정 실패');
    }
  }
}
