import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/domain/entities/user.dart';
import 'package:mongbi_app/domain/use_cases/nickname_setting.dart';

class NicknameViewModel extends StateNotifier<AsyncValue<User>> {
  NicknameViewModel(this.updateNicknameUseCase)
    : super(const AsyncValue.loading());
  final UpdateNicknameUseCase updateNicknameUseCase;

  Future<void> updateNickname(int userId, String nickname) async {
    state = const AsyncValue.loading();
    try {
      final user = await updateNicknameUseCase(
        userId: userId,
        nickname: nickname,
      );
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
