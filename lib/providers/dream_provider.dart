import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/data/data_sources/dream_data_source.dart';
import 'package:mongbi_app/data/data_sources/remote_dream_data_source.dart';
import 'package:mongbi_app/data/repositories/remote_dream_repository.dart';
import 'package:mongbi_app/domain/repositories/dream_repository.dart';

final dioProvider = Provider<Dio>(
  (ref) => Dio(BaseOptions(baseUrl: dotenv.env['BASE_URL']!)),
);

final _dreamDataSourceProvider = Provider<DreamDataSource>(
  (ref) => RemoteDreamDataSource(ref.read(dioProvider)),
);

final _dreamRepositoryProvider = Provider<DreamRepository>(
  (ref) => RemoteDreamRepository(ref.read(_dreamDataSourceProvider)),
);
