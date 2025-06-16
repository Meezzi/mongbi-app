import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/domain/entities/user.dart';
import 'package:mongbi_app/providers/nickname_provider.dart';

class NicknameViewModel extends Notifier<User?> {
  @override
  User? build() {
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
      final user = await ref.read(updateNicknameUseCaseProvider)(
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
