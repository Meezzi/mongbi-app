import 'package:mongbi_app/domain/entities/user.dart';

abstract interface class AuthRepository {
  Future<User> loginWithNaver(String accessToken);
  Future<User> loginWithKakao(String accessToken);
  Future<User> loginWithApple(String identity_token);
}
