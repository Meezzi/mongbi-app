import 'package:mongbi_app/data/data_sources/nickname_setting_data_source.dart';
import 'package:mongbi_app/data/repositories/remote_nickname_setting_repository.dart';
import 'package:mongbi_app/domain/entities/user.dart';

class NickNameSettingRepositoryImpl implements NickNameSettingRepository {

  NickNameSettingRepositoryImpl(this.dataSource);
  final NickNameSettingDataSource dataSource;

  @override
  Future<User> updateNickname(int userId, String nickname) async {
    final dto = await dataSource.nickNameSetting(userId: userId, nickname: nickname);
    return dto.toEntity();
  }
}
