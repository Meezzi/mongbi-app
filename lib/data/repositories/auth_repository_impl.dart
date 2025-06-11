import 'package:mongbi_app/data/data_sources/remote_kakao_auth_data_source.dart';
import 'package:mongbi_app/data/data_sources/remote_naver_auth_data_source.dart';
import 'package:mongbi_app/domain/entities/user.dart';
import 'package:mongbi_app/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteNaverAuthDataSource naverDataSource;
  final RemoteKakaoAuthDataSource kakaoDataSource;

  AuthRepositoryImpl({
    required this.naverDataSource,
    required this.kakaoDataSource,
  });

  @override
  Future<User> loginWithNaver() async {
    final response = await naverDataSource.login();
    return response.user.toEntity();
  }

@override
Future<User> loginWithKakao(String accessToken) async {
  final response = await kakaoDataSource.login(accessToken);
  return response.user.toEntity();
}
}
