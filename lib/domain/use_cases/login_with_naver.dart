import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginWithNaver {

  LoginWithNaver(this.repository);
  final AuthRepository repository;

  Future<User> execute() {
    return repository.loginWithNaver();
  }
}
