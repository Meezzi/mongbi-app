import 'package:dio/dio.dart';
import 'package:mongbi_app/core/secure_storage_service.dart';
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
      }
    }

    return handler.next(err);
  }
}
