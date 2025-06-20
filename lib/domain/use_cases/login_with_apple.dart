import 'package:mongbi_app/domain/entities/user.dart';
import 'package:mongbi_app/domain/repositories/auth_repository.dart';

class LoginWithApple {
  LoginWithApple(this.repository);
  final AuthRepository repository;

  Future<User> excute(String identity_token) {
    return repository.loginWithApple(identity_token);
  }
}
