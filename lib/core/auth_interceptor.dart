import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this.dio);
  final Dio dio;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final prefs = await SharedPreferences.getInstance();

    if (err.response?.statusCode == 401) {
      final refreshToken = prefs.getString('refresh_token');

      if (refreshToken != null) {
        try {
          final response = await dio.post(
            '/users/auth/refresh',
            data: {'refreshToken': refreshToken},
          );

          final newAccessToken = response.data['accessToken'];
          await prefs.setString('jwt_token', newAccessToken);

          final retryRequest = err.requestOptions;
          retryRequest.headers['Authorization'] = 'Bearer $newAccessToken';

          final cloneResponse = await dio.fetch(retryRequest);
          return handler.resolve(cloneResponse);
        } catch (e) {
          await prefs.clear();
          return handler.reject(err);
        }
      }
    }

    return handler.next(err);
  }
}
