import 'package:mongbi_app/data/repositories/remote_nickname_setting_repository.dart';
import 'package:mongbi_app/domain/entities/user.dart';


class UpdateNicknameUseCase {

  UpdateNicknameUseCase(this.repository);
  final NickNameSettingRepository repository;

  Future<User> call({required int userId, required String nickname}) {
    return repository.updateNickname(userId, nickname);
  }
}
