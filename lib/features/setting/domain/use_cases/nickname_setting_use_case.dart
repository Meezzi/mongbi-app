import 'package:mongbi_app/features/auth/domain/entities/user.dart';
import 'package:mongbi_app/features/setting/domain/repositories/nickname_repository.dart';

class UpdateNicknameUseCase {
  UpdateNicknameUseCase(this.repository);
  final NicknameSettingRepository repository;

  Future<User> call({required int userId, required String nickname}) {
    return repository.updateNickname(userId, nickname);
  }
}
