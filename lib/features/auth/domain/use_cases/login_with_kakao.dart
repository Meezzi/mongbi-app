import 'package:mongbi_app/domain/repositories/auth_repository.dart';
import 'package:mongbi_app/features/auth/domain/entities/user.dart';

class LoginWithKakao {
  LoginWithKakao(this.repository);
  final AuthRepository repository;

  Future<User> execute(String accessToken) async {
    return await repository.loginWithKakao(accessToken);
  }
}
