import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/domain/entities/challenge.dart';
import 'package:mongbi_app/providers/challenge_provider.dart';

class ChallengeViewModel extends AsyncNotifier<List<Challenge>> {
  @override
  Future<List<Challenge>> build() async {
    return [];
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
}
