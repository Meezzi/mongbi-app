import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/data/data_sources/dream_analysis_data_source.dart';
import 'package:mongbi_app/data/data_sources/dream_data_source.dart';
import 'package:mongbi_app/data/data_sources/remote_dream_analysis_data_source.dart';
import 'package:mongbi_app/data/data_sources/remote_dream_data_source.dart';
import 'package:mongbi_app/data/repositories/remote_dream_repository.dart';
import 'package:mongbi_app/domain/repositories/dream_repository.dart';
import 'package:mongbi_app/presentation/dream/models/dream_write_state.dart';
import 'package:mongbi_app/presentation/dream/view_models/dream_write_view_model.dart';
import 'package:mongbi_app/providers/core_providers.dart';

final _dreamDataSourceProvider = Provider<DreamDataSource>(
  (ref) => RemoteDreamDataSource(ref.read(dioProvider)),
);

final _dreamRepositoryProvider = Provider<DreamRepository>(
  (ref) => RemoteDreamRepository(ref.read(_dreamDataSourceProvider)),
);

// 꿈 해석 Provider
final _dreamAnalysisDataSource = Provider<DreamAnalysisDataSource>(
  (ref) => RemoteDreamAnalysisDataSourceImpl(
    dio: ref.read(dioProvider),
    apiKey: dotenv.env['CLAUDE_API_KEY']!,
    baseUrl: dotenv.env['CLAUDE_URL']!,
  ),
);

final dreamWriteViewModelProvider =
    StateNotifierProvider<DreamWriteViewModel, DreamWriteState>(
      (ref) => DreamWriteViewModel(),
    );
