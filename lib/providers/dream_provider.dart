import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/data/data_sources/dream_analysis_data_source.dart';
import 'package:mongbi_app/data/data_sources/dream_save_data_source.dart';
import 'package:mongbi_app/data/data_sources/remote_dream_analysis_data_source.dart';
import 'package:mongbi_app/data/data_sources/remote_dream_data_source.dart';
import 'package:mongbi_app/data/repositories/remote_dream_repository.dart';
import 'package:mongbi_app/domain/repositories/dream_repository.dart';
import 'package:mongbi_app/domain/use_cases/analyze_and_save_dream_use_case.dart';
import 'package:mongbi_app/domain/use_cases/analyze_dream_use_case.dart';
import 'package:mongbi_app/domain/use_cases/save_dream_use_case.dart';
import 'package:mongbi_app/presentation/dream/models/dream_interpretation_state.dart';
import 'package:mongbi_app/presentation/dream/models/dream_write_state.dart';
import 'package:mongbi_app/presentation/dream/view_models/dream_interpretation_view_model.dart';
import 'package:mongbi_app/presentation/dream/view_models/dream_write_view_model.dart';
import 'package:mongbi_app/providers/core_providers.dart';

final _dreamDataSourceProvider = Provider<DreamSaveDataSource>(
  (ref) => RemoteDreamDataSource(ref.read(dioProvider)),
);

final _dreamAnalysisDataSource = Provider<DreamAnalysisDataSource>(
  (ref) => RemoteDreamAnalysisDataSource(
    dio: ref.read(dioProvider),
    apiKey: dotenv.env['CLAUDE_API_KEY']!,
    baseUrl: dotenv.env['CLAUDE_URL']!,
  ),
);

final _dreamRepositoryProvider = Provider<DreamRepository>(
  (ref) => RemoteDreamRepository(
    ref.read(_dreamDataSourceProvider),
    ref.read(_dreamAnalysisDataSource),
  ),
);

final _analyzeDreamUseCaseProvider = Provider<AnalyzeDreamUseCase>(
  (ref) => AnalyzeDreamUseCase(ref.read(_dreamRepositoryProvider)),
);

final _saveDreamUseCaseProvider = Provider<SaveDreamUseCase>(
  (ref) => SaveDreamUseCase(ref.read(_dreamRepositoryProvider)),
);

final analyzeAndSaveDreamUseCaseProvider = Provider<AnalyzeAndSaveDreamUseCase>(
  (ref) => AnalyzeAndSaveDreamUseCase(
    ref.read(_analyzeDreamUseCaseProvider),
    ref.read(_saveDreamUseCaseProvider),
  ),
);

final dreamWriteViewModelProvider =
    NotifierProvider<DreamWriteViewModel, DreamWriteState>(
      () => DreamWriteViewModel(),
    );

final dreamInterpretationViewModelProvider =
    NotifierProvider<DreamInterpretationViewModel, DreamInterpretationState>(
      () => DreamInterpretationViewModel(),
    );
