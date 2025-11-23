import 'package:mongbi_app/features/challenge/data/dtos/challenge_dto.dart';

abstract interface class ChallengeDetailDataSource {
  Future<ChallengeDto> fetchChallengeDetail({required int challengeId});
}
