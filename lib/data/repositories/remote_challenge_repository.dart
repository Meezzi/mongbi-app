import 'package:mongbi_app/data/data_sources/challenge_data_source.dart';
import 'package:mongbi_app/domain/entities/challenge.dart';

class RemoteChallengeRepository {
  RemoteChallengeRepository(this.challengeDataSource);

  final ChallengeDataSource challengeDataSource;

  Future<List<Challenge>> fetchChallenge(int dreamScore) async {
    final challengeDtoList = await challengeDataSource.fetchChallenge(
      dreamScore,
    );

    return challengeDtoList.map((e) => e.toEntity()).toList();
  }
}
