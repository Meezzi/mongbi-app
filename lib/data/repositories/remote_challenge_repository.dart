import 'package:mongbi_app/data/data_sources/active_challenge_data_source.dart';
import 'package:mongbi_app/data/data_sources/challenge_detail_data_source.dart';
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
    required this.activeChallengeDataSource,
    required this.challengeDetailDataSource,
  });

  final FetchChallengeDataSource challengeDataSource;
  final SaveChallengeDataSource saveChallengeDataSource;
  final CompleteChallengeDataSource completeChallengeDataSource;
  final ActiveChallengeDataSource activeChallengeDataSource;
  final ChallengeDetailDataSource challengeDetailDataSource;

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

  @override
  Future<Challenge?> fetchActiveChallenge({required int uid}) async {
    // 현재 진행중인 챌린지 ID 가져오기
    final activeChallengeId = await activeChallengeDataSource
        .fetchActiveChallengeId(uid: uid);

    if (activeChallengeId == null) return null;

    // 챌린지 상세 정보 가져오기
    final challengeDto = await challengeDetailDataSource.fetchChallengeDetail(
      challengeId: activeChallengeId,
    );

    return challengeDto.toEntity();
  }

  @override
  Future<bool> completeChallenge({
    required int uid,
    required int challengeId,
    required String challengeStatus,
  }) async {
    return await completeChallengeDataSource.completeChallenge(
      uid: uid,
      challengeId: challengeId,
      challengeStatus: challengeStatus,
    );
  }
}
