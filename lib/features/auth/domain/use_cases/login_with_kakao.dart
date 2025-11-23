import 'package:mongbi_app/features/auth/domain/entities/user.dart';
import 'package:mongbi_app/features/auth/domain/repositories/auth_repository.dart';

class LoginWithKakao {
  LoginWithKakao(this.repository);
  final AuthRepository repository;

  Future<User> execute(String accessToken) async {
    return await repository.loginWithKakao(accessToken);
  }
}
