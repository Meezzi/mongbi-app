import 'package:mongbi_app/data/dtos/challenge_dto.dart';

abstract interface class ChallengeDetailDataSource {
  Future<ChallengeDto> fetchChallengeDetail({required int challengeId});
}
