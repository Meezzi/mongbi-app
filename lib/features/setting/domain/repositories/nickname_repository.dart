import 'package:mongbi_app/features/auth/domain/entities/user.dart';

abstract interface class NicknameSettingRepository {
  Future<User> updateNickname(int userId, String nickname);
}
