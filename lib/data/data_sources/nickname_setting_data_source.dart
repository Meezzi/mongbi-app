import 'package:mongbi_app/data/dtos/user_dto.dart';

abstract interface class NickNameSettingDataSource {
  Future<UserDto> nickNameSetting({
    required int userId,
    required String nickname,
  });
}
