import 'package:dio/dio.dart';
import 'package:mongbi_app/core/services/secure_storage_service.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this.dio);
  final Dio dio;

  final storageService = SecureStorageService();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await storageService.getAccessToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.requestOptions.path.contains('/auth/refresh')) {
      return handler.reject(err);
    }

    if (err.response?.statusCode == 401) {
      final refreshToken = await storageService.getRefreshToken();

      if (refreshToken != null) {
        try {
          final response = await dio.post(
            '/users/auth/refresh',
            data: {'refreshToken': refreshToken},
          );

          final newAccessToken = response.data['accessToken'];
          final newRefreshToken = response.data['refreshToken'];

          if (newAccessToken == null) {
            throw Exception('AccessToken이 응답에 없습니다.');
          }

          await storageService.saveAccessToken(newAccessToken);

          if (newRefreshToken != null) {
            await storageService.saveRefreshToken(newRefreshToken);
          }

          final retryRequest = err.requestOptions;
          retryRequest.headers['Authorization'] = 'Bearer $newAccessToken';

          final clonedResponse = await dio.fetch(retryRequest);
          return handler.resolve(clonedResponse);
        } catch (e, stackTrace) {
          await Sentry.captureException(
            e,
            stackTrace: stackTrace,
            withScope: (scope) {
              scope.setTag('error_type', 'token_refresh_failed');
              scope.setContexts('token_refresh_error', {
                'original_error': err.toString(),
                'error_message': e.toString(),
                'status_code': err.response?.statusCode,
              });
            },
          );

          await storageService.clearAll();
          return handler.reject(err);
        }
      } else {
        // refreshToken이 없으면 로그아웃 처리
        await storageService.clearAll();

        await Sentry.captureMessage(
          'RefreshToken이 없어서 로그아웃 처리',
          level: SentryLevel.warning,
          withScope: (scope) {
            scope.setTag('error_type', 'no_refresh_token');
            scope.setContexts('auth_error', {
              'original_error': err.toString(),
              'status_code': err.response?.statusCode,
            });
          },
        );

        return handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: 'RefreshToken이 없습니다. 다시 로그인해주세요.',
            type: DioExceptionType.badResponse,
            response: err.response,
          ),
        );
      }
    }

    return handler.next(err);
  }
}
