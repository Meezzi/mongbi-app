import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/core/auth_interceptor.dart';
import 'package:mongbi_app/core/secure_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((
  ref,
) async {
  return await SharedPreferences.getInstance();
});

final adminDioProvider = Provider<Dio>(
  (ref) => Dio(BaseOptions(baseUrl: dotenv.env['ADMIN_MONGBI_BASE_URL']!)),
);

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['MONGBI_BASE_URL']!,
      headers: {'Content-Type': 'application/json'},
    ),
  );

  /// AuthInterceptor 등록 (자동 accessToken 갱신 등)
  dio.interceptors.add(AuthInterceptor(dio));

  return dio;
});

final secureStorageServiceProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});
