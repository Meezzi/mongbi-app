import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:mongbi_app/data/dtos/login_response_dto.dart';
import 'package:mongbi_app/data/dtos/user_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemoteKakaoAuthDataSource {
  RemoteKakaoAuthDataSource(this.dio);
  final Dio dio;

  Future<LoginResponseDto> login(String accessToken) async {
    try {
      final response = await dio.post(
        '/users/kakao-login',
        data: jsonEncode({'access_token': accessToken}),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode != 201 || response.data['token'] == null) {
        throw Exception('서버 로그인 실패: ${response.data}');
      }

      final jwt = response.data['token'];
      final userDto = UserDto.fromJson(response.data['user']);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', jwt);

      return LoginResponseDto(token: jwt, user: userDto);
    } catch (e, s) {
      throw Exception('카카오 로그인 오류: $e \n $s');
    }
  }
}
