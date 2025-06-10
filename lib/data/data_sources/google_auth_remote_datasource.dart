import 'dart:convert';
import 'package:dio/dio.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

class RemoteGoogleAuthDataSource implements AuthRepository {
  final Dio dio;

  RemoteGoogleAuthDataSource(this.dio);

  @override
  Future<User> loginWithGoogle(String idToken) async {
    try {
      final response = await dio.post(
        '/auth/google',
        data: {'idToken': idToken},
      );

      if (response.statusCode == 201 && response.data['user'] != null) {
        return User.fromJson(response.data['user']);
      } else {
        throw Exception(response.data['message'] ?? '로그인 실패');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? '네트워크 오류');
    }
  }
}
