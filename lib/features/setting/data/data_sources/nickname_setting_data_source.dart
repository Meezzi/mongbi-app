import 'package:mongbi_app/features/setting/data/dtos/user_dto.dart';

abstract interface class NicknameSettingDataSource {
  Future<UserDto> updateNickname({
    required int userId,
    required String nickname,
  });
}
