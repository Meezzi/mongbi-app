import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:mongbi_app/data/dtos/login_response_dto.dart';
import 'package:mongbi_app/data/dtos/user_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sentry_flutter/sentry_flutter.dart'; // ✅ 추가

class RemoteAppleAuthDataSource {
  RemoteAppleAuthDataSource(this.dio);
  final Dio dio;

  Future<LoginResponseDto> login(String identity_token) async {
    try {
      final response = await dio.post(
        '/users/apple-login',
        data: jsonEncode({'identity_token': identity_token}),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode != 201 || response.data['token'] == null) {
        throw Exception('서버 로그인 실패: ${response.data}');
      }

      final jwt = response.data['token'];
      final userDto = UserDto.fromJson(response.data['user']);
      final userMap = response.data['user'];
      final int userIdx = userMap['USER_IDX'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', jwt);
      await prefs.setInt('user_id', userIdx);
      await prefs.setBool('isLogined', true);

      return LoginResponseDto(token: jwt, user: userDto);
    } catch (e, s) {
      await Sentry.captureException(
        e,
        stackTrace: s,
        withScope: (scope) {
          scope.setExtra('context', '🚨 애플 로그인 에러 발생');
        },
      );
      throw Exception('애플 로그인 오류: $e \n$s');
    }
  }
}
