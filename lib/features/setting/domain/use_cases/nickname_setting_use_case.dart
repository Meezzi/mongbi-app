import 'package:mongbi_app/domain/repositories/nickname_repository.dart';
import 'package:mongbi_app/features/auth/domain/entities/user.dart';

class UpdateNicknameUseCase {
  UpdateNicknameUseCase(this.repository);
  final NicknameSettingRepository repository;

  Future<User> call({required int userId, required String nickname}) {
    return repository.updateNickname(userId, nickname);
  }
}
