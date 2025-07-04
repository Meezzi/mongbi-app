import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:mongbi_app/core/exceptions/auth_custom_exception.dart';
import 'package:mongbi_app/core/secure_storage_service.dart';
import 'package:mongbi_app/data/dtos/login_response_dto.dart';
import 'package:mongbi_app/data/dtos/user_dto.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

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
        final error = Exception('서버 로그인 실패: ${response.data}');
        await Sentry.captureException(
          error,
          withScope: (scope) {
            scope.setExtra('accessToken', accessToken);
            scope.setExtra('response', response.data);
          },
        );
        throw const AuthFailedException('로그인에 실패했습니다.');
      }

      final jwt = response.data['token'];
      final refreshToken = response.data['refreshToken'];
      final userDto = UserDto.fromJson(response.data['user']);

      await storageService.saveAccessToken(jwt);
      await storageService.saveRefreshToken(refreshToken);
      await storageService.saveUserIdx(userDto.userIdx);

      return LoginResponseDto(token: jwt, user: userDto);
    } on DioException catch (e, s) {
      final errorData = e.response?.data;
      final errorMessage =
          errorData is Map ? errorData['message'] : '알 수 없는 오류';
      final errorCode = errorData is Map ? errorData['code'] : null;

      await Sentry.captureException(
        e,
        stackTrace: s,
        withScope: (scope) {
          scope.setTag('auth', 'kakao');
          scope.setExtra('code', errorCode);
          scope.setExtra('message', errorMessage);
        },
      );

      if (errorCode == 1259) {
        throw const WithdrawnUserException('탈퇴한 회원입니다. 재가입이 불가합니다.');
      }

      throw const AuthFailedException('로그인에 실패했습니다.');
    } on PlatformException catch (e) {
      if (e.code == 'CANCELED') {
        throw const AuthCancelledException('로그인이 취소되었습니다.');
      }
      throw const AuthFailedException('로그인에 실패했습니다.');
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      throw const AuthFailedException('로그인에 실패했습니다.');
    }
  }
}
