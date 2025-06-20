import 'package:mongbi_app/data/data_sources/challenge_data_source.dart';
import 'package:mongbi_app/domain/entities/challenge.dart';
import 'package:mongbi_app/domain/repositories/challenge_repository.dart';

class RemoteChallengeRepository implements ChallengeRepository {
  RemoteChallengeRepository({required this.challengeDataSource});

  final ChallengeDataSource challengeDataSource;

  @override
  Future<List<Challenge>> fetchChallenge(int dreamScore) async {
    final challengeDtoList = await challengeDataSource.fetchChallenge(
      dreamScore,
    );

    return challengeDtoList.map((e) => e.toEntity()).toList();
  }
}
