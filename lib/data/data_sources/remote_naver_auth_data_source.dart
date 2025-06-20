import 'package:dio/dio.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:mongbi_app/core/secure_storage_service.dart';
import 'package:mongbi_app/data/dtos/login_response_dto.dart';
import 'package:mongbi_app/data/dtos/user_dto.dart';

class RemoteNaverAuthDataSource {
  RemoteNaverAuthDataSource(this.dio);
  final Dio dio;
  final storageService = SecureStorageService();

  Future<LoginResponseDto> login(String accessToken) async {
    String jwt = '';
    UserDto? userDto;
    try {
      final tokenResult = await FlutterNaverLogin.getCurrentAccessToken();

      final accessToken = tokenResult.accessToken;
      final response = await dio.post(
        '/users/naver-login',
        data: {'access_token': accessToken},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 201 && response.data['token'] != null) {
        jwt = response.data['token'];

        await storageService.saveAccessToken(jwt);
        userDto = UserDto.fromJson(response.data['user']);
      } else {}
    } catch (e) {}
    return LoginResponseDto(token: jwt, user: userDto!);
  }
}
