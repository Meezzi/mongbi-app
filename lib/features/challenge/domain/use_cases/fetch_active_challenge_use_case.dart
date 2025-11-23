import 'package:mongbi_app/features/challenge/domain/entities/challenge.dart';
import 'package:mongbi_app/features/challenge/domain/repositories/challenge_repository.dart';

class FetchActiveChallengeUseCase {
  FetchActiveChallengeUseCase({required this.challengeRepository});
  final ChallengeRepository challengeRepository;

  Future<Challenge?> execute({required int uid}) {
    return challengeRepository.fetchActiveChallenge(uid: uid);
  }
}
