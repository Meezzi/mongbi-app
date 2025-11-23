import 'package:mongbi_app/features/auth/domain/entities/user.dart';
import 'package:mongbi_app/features/auth/domain/repositories/auth_repository.dart';

class LoginWithApple {
  LoginWithApple(this.repository);
  final AuthRepository repository;

  Future<User> execute(String identity_token) {
    return repository.loginWithApple(identity_token);
  }
}
