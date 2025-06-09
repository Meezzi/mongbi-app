import 'package:dio/dio.dart';
import 'package:mongbi_app/data/data_sources/dream_analysis_data_source.dart';

class RemoteDreamAnalysisDataSource implements DreamAnalysisDataSource {
  RemoteDreamAnalysisDataSource({
    required this.dio,
    required this.apiKey,
    required this.baseUrl,
  });

  final Dio dio;
  final String apiKey;
  final String baseUrl;

  @override
  Future<String> analyzeDream(String dreamContent, int dreamScore) async {
    try {
      final prompt = '''
너는 사용자의 꿈을 먹는 친근한 도깨비 몽비야! 꿈을 맛있게 먹고 해석해주는 전문가지!

📝 분석할 꿈:
꿈의 내용: "$dreamContent"
꿈을 꾸고 난 후 기분: $dreamScore

🎯 답변 형식 (총 1000자 이내):

🔑 **꿈의 키워드**
- 핵심단어 3-5개를 간단히 나열

💭 **심리 상태 키워드**  
- 현재 심리상태 키워드 3-5개 나열

✨ **꿈의 해석**
꿈 속 각 요소들의 상징적 의미를 구체적으로 설명하고, 전체적인 해몽을 자세히 풀어서 알려줘.

🧠 **심리 상태 해석**
현재 마음 상태와 꿈과의 연관성을 자세히 분석해줘.

💡 **몽비의 조언**
따뜻하고 실용적인 조언 한마디!

* 친근하고 재미있게 반말로 대화하듯 써줘
''';

      final requestBody = {
        'model': 'claude-3-5-sonnet-20241022',
        'max_tokens': 4024,
        'messages': [
          {'role': 'user', 'content': prompt},
        ],
      };

      final response = await dio.post(
        baseUrl,
        options: Options(
          headers: {
            'x-api-key': apiKey,
            'anthropic-version': '2023-06-01',
            'Content-Type': 'application/json',
          },
        ),
        data: requestBody,
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final text = data['content'][0]['text'] as String;

        return text;
      } else {
        throw Exception(
          'Claude API 호출 실패: ${response.statusCode} ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('API Key가 잘못되었습니다. 다시 확인해주세요.');
      } else if (e.response?.statusCode == 404) {
        throw Exception('API 엔드포인트를 찾을 수 없습니다. URL 또는 모델명을 확인해주세요.');
      }

      throw Exception('네트워크 오류: ${e.message}');
    } catch (e) {
      throw Exception('알 수 없는 오류: $e');
    }
  }
}
