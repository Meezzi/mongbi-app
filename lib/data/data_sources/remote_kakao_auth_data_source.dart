import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:mongbi_app/core/secure_storage_service.dart';
import 'package:mongbi_app/data/dtos/login_response_dto.dart';
import 'package:mongbi_app/data/dtos/user_dto.dart';

class RemoteKakaoAuthDataSource {
  RemoteKakaoAuthDataSource(this.dio);
  final Dio dio;
  final storageService = SecureStorageService();

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
      final refreshToken = response.data['refreshToken'];
      final userDto = UserDto.fromJson(response.data['user']);

      await storageService.saveAccessToken(jwt);
      await storageService.saveRefreshToken(refreshToken);
      if (response.data['user'] != null) {
        await storageService.saveUserIdx(userDto.userIdx); 
      } else {
        throw Exception('로그인 응답에 user 정보가 없습니다.');
      }

      return LoginResponseDto(token: jwt, user: userDto);
    } catch (e, s) {
      throw Exception('카카오 로그인 오류: $e \n $s');
    }
  }
}
//TODO 엑세스 토큰 유효기간 짧게 잡고 리프래쉬 토큰 재발급 해주는 API 개발 및 연동