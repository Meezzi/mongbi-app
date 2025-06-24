import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/core/secure_storage_service.dart';
import 'package:mongbi_app/domain/entities/challenge.dart';
import 'package:mongbi_app/providers/challenge_provider.dart';
import 'package:mongbi_app/providers/dream_provider.dart';

class ChallengeViewModel extends AsyncNotifier<List<Challenge>> {
  int? selectedChallengeIndex;

  @override
  Future<List<Challenge>> build() async {
    return [];
  }

  void selectChallenge(int index) {
    selectedChallengeIndex = index;
    state = AsyncValue.data(state.value ?? []);
  }

  Future<void> loadChallenges(int dreamScore) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchChallenges(dreamScore));
  }

  Future<List<Challenge>> _fetchChallenges(int dreamScore) async {
    final result = await ref
        .read(fetchChallengeUseCaseProvider)
        .execute(dreamScore);
    return result;
  }

  Future<bool> saveChallenge() async {
    final challenges = state.value;
    final selectedIndex = selectedChallengeIndex;

    if (challenges == null || selectedIndex == null) {
      return false;
    }

    final challengeId = challenges[selectedIndex].id;
    final uid = await SecureStorageService().getUserIdx();
    final currentDreamId =
        ref.read(dreamInterpretationViewModelProvider).dreamId;

    if (uid == null) {
      return false;
    }
    final result = await ref
        .read(saveChallengeUseCaseProvider)
        .saveChallenge(
          dreamId: currentDreamId,
          uid: uid,
          challengeId: challengeId,
        );

    return result;
  }
}
