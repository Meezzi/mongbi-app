import 'package:mongbi_app/features/auth/domain/entities/user.dart';
import 'package:mongbi_app/features/auth/domain/repositories/auth_repository.dart';

class LoginWithNaver {
  LoginWithNaver(this.repository);
  final AuthRepository repository;

  Future<User> execute(String accessToken) {
    return repository.loginWithNaver(accessToken);
  }
}
