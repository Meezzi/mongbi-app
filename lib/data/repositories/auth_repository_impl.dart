import 'package:mongbi_app/data/data_sources/naver_auth_data_source.dart';
import 'package:mongbi_app/domain/entities/user.dart';
import 'package:mongbi_app/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final NaverAuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<User> loginWithNaver() => dataSource.login();
}
