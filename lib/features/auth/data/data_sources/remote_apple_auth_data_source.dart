import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mongbi_app/core/exceptions/auth_custom_exception.dart';
import 'package:mongbi_app/core/secure_storage_service.dart';
import 'package:mongbi_app/data/dtos/user_dto.dart';
import 'package:mongbi_app/features/auth/data/dtos/login_response_dto.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class RemoteAppleAuthDataSource {
  RemoteAppleAuthDataSource(this.dio);
  final Dio dio;
  final storageService = SecureStorageService();

  Future<LoginResponseDto> login(String identity_token) async {
    try {
      final response = await dio.post(
        '/users/apple-login',
        data: jsonEncode({'identity_token': identity_token}),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode != 201 || response.data['token'] == null) {
        final error = Exception('서버 로그인 실패: ${response.data}');
        await Sentry.captureException(error);
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
          scope.setTag('auth', 'apple');
          scope.setExtra('code', errorCode);
          scope.setExtra('message', errorMessage);
        },
      );

      if (errorCode == 1259) {
        throw const WithdrawnUserException('탈퇴한 회원입니다. 재가입이 불가합니다.');
      }

      throw const AuthFailedException('로그인에 실패했습니다.');
    } catch (e, s) {
      if (e is SignInWithAppleAuthorizationException) {
        if (e.code == AuthorizationErrorCode.canceled) {
          throw const AuthCancelledException('로그인이 취소되었습니다.');
        }
      }

      await Sentry.captureException(
        e,
        stackTrace: s,
        withScope: (scope) {
          scope.setExtra('context', '🚨 애플 로그인 에러 발생');
        },
      );
      throw const AuthFailedException('로그인에 실패했습니다.');
    }
  }
}
