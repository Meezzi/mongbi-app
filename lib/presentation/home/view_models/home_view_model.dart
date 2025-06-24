import 'package:flutter_riverpod/flutter_riverpod.dart';
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
}
