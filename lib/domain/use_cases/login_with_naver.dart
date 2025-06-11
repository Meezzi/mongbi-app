import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginWithNaver {
  final AuthRepository repository;

  LoginWithNaver(this.repository);

  Future<User> execute() {
    return repository.loginWithNaver();
  }
}
