import 'package:mongbi_app/domain/repositories/auth_repository.dart';
import 'package:mongbi_app/features/auth/domain/entities/user.dart';

class LoginWithApple {
  LoginWithApple(this.repository);
  final AuthRepository repository;

  Future<User> execute(String identity_token) {
    return repository.loginWithApple(identity_token);
  }
}
