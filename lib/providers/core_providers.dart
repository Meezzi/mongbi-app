import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/core/auth_interceptor.dart';

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

  dio.interceptors.add(AuthInterceptor());

  return dio;
});
