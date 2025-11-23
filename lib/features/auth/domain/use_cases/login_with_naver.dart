import 'package:mongbi_app/domain/repositories/auth_repository.dart';
import 'package:mongbi_app/features/auth/domain/entities/user.dart';

class LoginWithNaver {
  LoginWithNaver(this.repository);
  final AuthRepository repository;

  Future<User> execute(String accessToken) {
    return repository.loginWithNaver(accessToken);
  }
}
