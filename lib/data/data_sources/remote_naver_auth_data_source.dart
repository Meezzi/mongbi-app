import 'package:dio/dio.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:mongbi_app/data/dtos/login_response_dto.dart';
import 'package:mongbi_app/data/dtos/user_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemoteNaverAuthDataSource {
  RemoteNaverAuthDataSource(this.dio);
  final Dio dio;

  Future<LoginResponseDto> login() async {
    String jwt = '';
    UserDto? userDto;
    try {} catch (e) {
      //TODO 오류처리 추후 예정
    }

    try {
      final tokenResult = await FlutterNaverLogin.getCurrentAccessToken();
      if (!tokenResult.isValid()) {
        throw Exception('유효하지 않은 accessToken');
      }

      final accessToken = tokenResult.accessToken;
      final response = await dio.post(
        '/users/naver-login',
        data: {'access_token': accessToken},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 201 && response.data['token'] != null) {
        jwt = response.data['token'];
        userDto = UserDto.fromJson(response.data['user']);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt_token', jwt);
      } else {}
    } catch (e) {
      //TODO 오류처리 추후 예정
    }
    return LoginResponseDto(token: jwt, user: userDto!);
  }
}
