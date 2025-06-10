import 'package:dio/dio.dart';
import 'package:mongbi_app/data/data_sources/google_auth_remote_datasource.dart';
import 'package:mongbi_app/domain/entities/user.dart';
import 'package:mongbi_app/domain/repositories/auth_repository.dart';

class GoogleLoginUseCase {
  final AuthRepository _repository = RemoteGoogleAuthDataSource(Dio());

  Future<User> execute(String idToken) {
    return _repository.loginWithGoogle(idToken);
  }
}
