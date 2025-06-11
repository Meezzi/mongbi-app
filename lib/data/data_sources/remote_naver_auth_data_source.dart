import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_naver_login/interface/types/naver_login_status.dart';
import 'package:mongbi_app/data/dtos/login_response_dto.dart';
import 'package:mongbi_app/data/dtos/user_dto.dart';
import 'package:mongbi_app/domain/entities/user.dart';

class RemoteNaverAuthDataSource {
  final Dio dio;

  RemoteNaverAuthDataSource(this.dio);

  Future<LoginResponseDto> login() async {
    String jwt='';
    UserDto? userDto;
    try {
      final loginResult = await FlutterNaverLogin.logIn();
    } catch (e) {}

    try {
      final tokenResult = await FlutterNaverLogin.getCurrentAccessToken();
      if (!tokenResult.isValid()) {
        throw Exception('유효하지 않은 accessToken');
      }

      final accessToken = tokenResult.accessToken;

      // 3. 서버에 accessToken 전송
      final response = await dio.post(
        '/users/naver-login',
        data: {'access_token': accessToken},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      // 4. 서버 응답 확인
      if (response.statusCode == 201 && response.data['token'] != null) {
         jwt = response.data['token'];
         userDto = UserDto.fromJson(response.data['user']);
        
      } else {}
    } catch (e) {
    }
    return LoginResponseDto(token: jwt, user: userDto!);
  }
}
