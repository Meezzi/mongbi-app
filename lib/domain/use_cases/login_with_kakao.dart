import 'package:mongbi_app/domain/entities/user.dart';
import 'package:mongbi_app/domain/repositories/auth_repository.dart';

class LoginWithKakao {

  LoginWithKakao(this.repository);
  final AuthRepository repository;

  Future<User> execute(String accessToken) {
    return repository.loginWithKakao(accessToken);
  }
}
