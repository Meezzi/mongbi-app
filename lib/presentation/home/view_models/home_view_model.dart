import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/core/secure_storage_service.dart';
import 'package:mongbi_app/presentation/home/models/home_state.dart';
import 'package:mongbi_app/providers/challenge_provider.dart';

class HomeViewModel extends Notifier<HomeState> {
  @override
  HomeState build() {
    return HomeState();
  }

  Future<void> fetchActiveChallenge({required int uid}) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final challenge = await ref
          .read(fetchActiveChallengeUseCaseProvider)
          .execute(uid: uid);

      state = state.copyWith(challenge: challenge, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> completeChallenge({required bool isComplete}) async {
    if (state.challenge == null) return;

    state = state.copyWith(isCompleting: true);

    final uid = await SecureStorageService().getUserIdx();
    final challengeId = state.challenge!.id;
    final challengeStatus = isComplete ? 'COMPLETED' : 'ABANDONED';

    if (uid == null) {
      state = state.copyWith(isCompleting: false, error: '사용자 정보를 찾을 수 없습니다.');
      return;
    }

    try {
      final success = await ref
          .read(completeChallengeUseCaseProvider)
          .execute(
            uid: uid,
            challengeId: challengeId,
            challengeStatus: challengeStatus,
          );

      if (success) {
        state = HomeState();
      } else {
        state = state.copyWith(
          isCompleting: false,
          error: isComplete ? '챌린지 완료에 실패했습니다.' : '챌린지 포기에 실패했습니다.',
        );
      }
    } catch (e) {
      state = state.copyWith(isCompleting: false, error: e.toString());
    }
  }
}
