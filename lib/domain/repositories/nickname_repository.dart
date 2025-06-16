import 'package:mongbi_app/domain/entities/user.dart';

abstract interface class NicknameSettingRepository {
  Future<User> updateNickname(int userId, String nickname);
}
