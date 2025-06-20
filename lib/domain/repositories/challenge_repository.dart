import 'package:mongbi_app/domain/entities/challenge.dart';

abstract interface class ChallengeRepository {
  Future<List<Challenge>> fetchChallenge(int dreamScore);
}
