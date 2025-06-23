import 'package:mongbi_app/data/data_sources/complete_challenge_data_source.dart';
import 'package:mongbi_app/data/data_sources/fetch_challenge_data_source.dart';
import 'package:mongbi_app/data/data_sources/save_challenge_data_source.dart';
import 'package:mongbi_app/domain/entities/challenge.dart';
import 'package:mongbi_app/domain/repositories/challenge_repository.dart';

class RemoteChallengeRepository implements ChallengeRepository {
  RemoteChallengeRepository({
    required this.challengeDataSource,
    required this.saveChallengeDataSource,
    required this.completeChallengeDataSource,
  });

  final FetchChallengeDataSource challengeDataSource;
  final SaveChallengeDataSource saveChallengeDataSource;
  final CompleteChallengeDataSource completeChallengeDataSource;

  @override
  Future<List<Challenge>> fetchChallenge(int dreamScore) async {
    final challengeDtoList = await challengeDataSource.fetchChallenge(
      dreamScore,
    );

    return challengeDtoList.map((e) => e.toEntity()).toList();
  }

  @override
  Future<bool> saveChallenge({
    required int dreamId,
    required int uid,
    required int challengeId,
  }) {
    return saveChallengeDataSource.saveChallenge(
      dreamId: dreamId,
      uid: uid,
      challengeId: challengeId,
    );
  }

  Future<bool> completeChallenge({
    required int uid,
    required int dreamId,
    required int challengeId,
  }) async {
    return await completeChallengeDataSource.completeChallenge(
      uid: uid,
      dreamId: dreamId,
      challengeId: challengeId,
    );
  }
}
