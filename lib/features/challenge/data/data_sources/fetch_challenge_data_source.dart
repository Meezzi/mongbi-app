import 'package:mongbi_app/features/challenge/data/dtos/challenge_dto.dart';

abstract interface class FetchChallengeDataSource {
  Future<List<ChallengeDto>> fetchChallenge(int dreamScore);
}
