import 'package:dio/dio.dart';
import 'package:mongbi_app/data/data_sources/fetch_challenge_data_source.dart';
import 'package:mongbi_app/data/dtos/challenge_dto.dart';
import 'package:sentry_flutter/sentry_flutter.dart'; // ✅ 추가

class RemoteFetchChallengeDataSource implements FetchChallengeDataSource {
  RemoteFetchChallengeDataSource({required this.dio});

  final Dio dio;

  @override
  Future<List<ChallengeDto>> fetchChallenge(int dreamScore) async {
    try {
      final response = await dio.get('/api/challenges/trait/$dreamScore');

      if (response.statusCode == 200 && response.data['success'] == true) {
        final challengeList = List<Map<String, dynamic>>.from(
          response.data['data'],
        );

        return challengeList.map((e) => ChallengeDto.fromJson(e)).toList();
      } else {
        final error = Exception(response.data['message'] ?? '알 수 없는 오류가 발생하였습니다.');
        await Sentry.captureException(
          error,
          withScope: (scope) {
            scope.setExtra('dreamScore', dreamScore);
          },
        );
        throw error;
      }
    } on DioException catch (e, s) {
      await Sentry.captureException(
        e,
        stackTrace: s,
        withScope: (scope) {
          scope.setExtra('dreamScore', dreamScore);
        },
      );
      throw Exception(e.message ?? '네트워크 오류가 발생하였습니다.');
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      throw Exception('챌린지 불러오기 중 오류 발생: $e');
    }
  }
}
