import 'package:mongbi_app/domain/entities/user.dart';
import 'package:mongbi_app/domain/repositories/auth_repository.dart';

class LoginWithNaver {

  LoginWithNaver(this.repository);
  final AuthRepository repository;

  Future<User> execute() {
    return repository.loginWithNaver();
  }
}
