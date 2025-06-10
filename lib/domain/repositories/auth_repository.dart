import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> loginWithGoogle(String idToken);
}
