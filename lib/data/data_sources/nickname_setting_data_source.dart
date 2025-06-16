import 'package:mongbi_app/data/dtos/user_dto.dart';

abstract interface class NicknameSettingDataSource {
  Future<UserDto> updateNickname({
    required int userId,
    required String nickname,
  });
}
