import 'package:mongbi_app/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> loginWithNaver();
  Future<User> loginWithKakao(String accessToken);
}
