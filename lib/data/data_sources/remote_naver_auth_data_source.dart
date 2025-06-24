import 'package:dio/dio.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:mongbi_app/core/secure_storage_service.dart';
import 'package:mongbi_app/data/dtos/login_response_dto.dart';
import 'package:mongbi_app/data/dtos/user_dto.dart';
import 'package:sentry_flutter/sentry_flutter.dart'; // ✅ Sentry 추가

class RemoteNaverAuthDataSource {
  RemoteNaverAuthDataSource(this.dio);
  final Dio dio;
  final storageService = SecureStorageService();

  Future<LoginResponseDto> login(String accessToken) async {
    String jwt = '';
    String refreshToken = '';
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
        refreshToken = response.data['refreshToken'];

        await storageService.saveAccessToken(jwt);
        await storageService.saveRefreshToken(refreshToken);

        if (response.data['user'] != null) {
          userDto = UserDto.fromJson(response.data['user']);
          await storageService.saveUserIdx(userDto.userIdx);
        } else {
          final error = Exception('로그인 응답에 user 정보가 없습니다.');
          await Sentry.captureException(error);
          throw error;
        }
      } else {
        final error = Exception('로그인 실패: 토큰이 없거나 잘못된 응답입니다.');
        await Sentry.captureException(
          error,
          withScope: (scope) {
            scope.setExtra('accessToken', accessToken);
            scope.setTag('auth', 'naver');
          },
        );
        throw error;
      }
    } catch (e, s) {
      await Sentry.captureException(
        e,
        stackTrace: s,
        withScope: (scope) {
          scope.setTag('auth', 'naver');
        },
      );
      rethrow;
    }

    return LoginResponseDto(token: jwt, user: userDto!);
  }
}
