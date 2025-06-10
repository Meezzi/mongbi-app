import 'package:dio/dio.dart';
import 'package:mongbi_app/data/data_sources/auth_data_source.dart';
import 'package:mongbi_app/data/dtos/user_dto.dart';
import 'package:mongbi_app/data/dtos/login_response_dto.dart';

class RemoteAuthDataSource implements AuthDataSource {
  final Dio dio;

  RemoteAuthDataSource(this.dio);

  @override
  Future<LoginResponseDto> googleLogin(String idToken) async {
    try {
      final response = await dio.post(
        '/users/google-login',
        data: {'idToken': idToken},
      );

      if (response.statusCode == 201 && response.data['token'] != null) {
        final token = response.data['token'];
        final user = UserDto.fromJson(response.data['user']);
        return LoginResponseDto(token: token, user: user); // ✅ 클래스 기반으로 반환
      } else {
        throw Exception(response.data['message'] ?? '로그인 실패');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? '네트워크 오류 발생');
    }
  }
}
