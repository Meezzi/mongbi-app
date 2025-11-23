import 'package:mongbi_app/domain/repositories/nickname_repository.dart';
import 'package:mongbi_app/features/auth/domain/entities/user.dart';
import 'package:mongbi_app/features/setting/data/data_sources/nickname_setting_data_source.dart';

class RemoteNicknameSettingRepository implements NicknameSettingRepository {
  RemoteNicknameSettingRepository(this.dataSource);
  final NicknameSettingDataSource dataSource;

  @override
  Future<User> updateNickname(int userId, String nickname) async {
    final dto = await dataSource.updateNickname(
      userId: userId,
      nickname: nickname,
    );
    return dto.toEntity();
  }
}
