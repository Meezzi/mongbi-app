import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/domain/entities/user.dart';
import 'package:mongbi_app/domain/use_cases/nickname_setting.dart';
import 'package:mongbi_app/providers/nickname_provider.dart';

class NicknameViewModel extends Notifier<User?> {
  late final UpdateNicknameUseCase _updateNicknameUseCase;

  @override
  User? build() {
    _updateNicknameUseCase = ref.read(updateNicknameUseCaseProvider);
    return null;
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> updateNickname({
    required int userId,
    required String nickname,
  }) async {
    _isLoading = true;
    try {
      final user = await _updateNicknameUseCase(
        userId: userId,
        nickname: nickname,
      );
      state = user;
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
    }
  }
}
