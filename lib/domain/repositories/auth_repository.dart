import 'package:mongbi_app/domain/entities/user.dart';

abstract interface class AuthRepository {
  Future<User> loginWithNaver();
  Future<User> loginWithKakao(String accessToken);
}
