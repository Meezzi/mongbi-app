import 'package:mongbi_app/domain/entities/challenge.dart';
import 'package:mongbi_app/domain/repositories/challenge_repository.dart';

class FetchChallengeUseCase {
  FetchChallengeUseCase({required this.challengeRepository});

  final ChallengeRepository challengeRepository;

  Future<List<Challenge>> execute(int dreamScore) async {
    return await challengeRepository.fetchChallenge(dreamScore);
  }
}
