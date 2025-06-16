import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/data/data_sources/nickname_setting_data_source.dart';
import 'package:mongbi_app/data/data_sources/remote_nickname_setting_data_source.dart';
import 'package:mongbi_app/data/repositories/remote_nickname_setting_repository.dart';
import 'package:mongbi_app/domain/entities/user.dart';
import 'package:mongbi_app/domain/repositories/nickname_repository.dart';
import 'package:mongbi_app/domain/use_cases/nickname_setting.dart';
import 'package:mongbi_app/presentation/profile/view_models/nickname_setting_view_model.dart';
import 'package:mongbi_app/providers/core_providers.dart';

final _nicknameSettingDataSourceProvider = Provider<NickNameSettingDataSource>(
  (ref) => RemoteNickNameSettingDataSource(ref.read(dioProvider)),
);


final _nicknameRepositoryProvider = Provider<NickNameSettingRepository>((ref) {
  final remoteDataSource = ref.watch(_nicknameSettingDataSourceProvider);
  return RemoteNickNameSettingRepository(remoteDataSource);
});


final updateNicknameUseCaseProvider = Provider<UpdateNicknameUseCase>((ref) {
  final repository = ref.watch(_nicknameRepositoryProvider);
  return UpdateNicknameUseCase(repository);
});

final nicknameViewModelProvider =
    NotifierProvider<NicknameViewModel, User?>(() => NicknameViewModel());
