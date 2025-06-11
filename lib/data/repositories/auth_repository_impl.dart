import 'package:mongbi_app/data/data_sources/remote_naver_auth_data_source.dart';
import 'package:mongbi_app/domain/entities/user.dart';
import 'package:mongbi_app/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteNaverAuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<User> loginWithNaver() async {
    final response = await dataSource.login(); // LoginResponseDto 반환
    return response.user.toEntity(); // UserDto → User
  }
}
