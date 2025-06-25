import 'package:dio/dio.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:mongbi_app/core/exceptions/auth_custom_exception.dart';
import 'package:mongbi_app/core/secure_storage_service.dart';
import 'package:mongbi_app/data/dtos/login_response_dto.dart';
import 'package:mongbi_app/data/dtos/user_dto.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

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
          throw const AuthFailedException('로그인에 실패했습니다.');
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
        throw const AuthFailedException('로그인에 실패했습니다.');
      }
    } on DioException catch (e, s) {
      final errorData = e.response?.data;
      final errorMessage =
          errorData is Map ? errorData['message'] : '알 수 없는 오류';
      final errorCode = errorData is Map ? errorData['code'] : null;

      await Sentry.captureException(
        e,
        stackTrace: s,
        withScope: (scope) {
          scope.setTag('auth', 'naver');
          scope.setExtra('code', errorCode);
          scope.setExtra('message', errorMessage);
        },
      );

      if (errorCode == 1259) {
        throw const WithdrawnUserException('탈퇴한 회원입니다. 재가입이 불가합니다.');
      }

      throw const AuthFailedException('로그인에 실패했습니다.');
    } catch (e, s) {
      if (e is AuthCancelledException ||
          e is AuthFailedException ||
          e is WithdrawnUserException) {
        rethrow;
      }

      await Sentry.captureException(e, stackTrace: s);
      throw const AuthFailedException('로그인에 실패했습니다.');
    }

    return LoginResponseDto(token: jwt, user: userDto!);
  }
}
