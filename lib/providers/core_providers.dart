import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>(
  (ref) => Dio(BaseOptions(baseUrl: dotenv.env['MONGBI_BASE_URL']!)),
);

final admindioProvider = Provider<Dio>(
  (ref) => Dio(BaseOptions(baseUrl: dotenv.env['ADMIN_MONGBI_BASE_URL']!)),
);
  (ref) => Dio(
    BaseOptions(
      baseUrl: dotenv.env['MONGBI_BASE_URL']!,
      headers: {
        'Authorization': 'Bearer ${dotenv.env['BEARER_KEY']}',
        'Content-Type': 'application/json',
      },
    ),
  ),
);

