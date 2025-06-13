import 'package:mongbi_app/domain/entities/user.dart';

abstract class NickNameSettingRepository {
  Future<User> updateNickname(int userId, String nickname);
}
