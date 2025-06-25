import 'package:mongbi_app/data/data_sources/remote_apple_auth_data_source.dart';
import 'package:mongbi_app/data/data_sources/remote_kakao_auth_data_source.dart';
import 'package:mongbi_app/data/data_sources/remote_naver_auth_data_source.dart';
import 'package:mongbi_app/domain/entities/user.dart';
import 'package:mongbi_app/domain/repositories/auth_repository.dart';

class RemoteAuthRepository implements AuthRepository {
  RemoteAuthRepository({
    required this.naverDataSource,
    required this.kakaoDataSource,
    required this.appleDataSource,
  });
  final RemoteNaverAuthDataSource naverDataSource;
  final RemoteKakaoAuthDataSource kakaoDataSource;
  final RemoteAppleAuthDataSource appleDataSource;

  @override
  Future<User> loginWithNaver(String accessToken) async {
    final response = await naverDataSource.login(accessToken);
    return response.user.toEntity();
  }

  @override
  Future<User> loginWithKakao(String accessToken) async {
    final response = await kakaoDataSource.login(accessToken);
    return response.user.toEntity();
  }

  @override
  Future<User> loginWithApple(String identity_token) async {
    final response = await appleDataSource.login(identity_token);
    return response.user.toEntity();
  }
}
