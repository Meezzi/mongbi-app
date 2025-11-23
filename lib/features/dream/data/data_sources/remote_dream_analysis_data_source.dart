import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mongbi_app/features/dream/data/data_sources/dream_analysis_data_source.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class RemoteDreamAnalysisDataSource implements DreamAnalysisDataSource {
  RemoteDreamAnalysisDataSource({required this.dio});

  final Dio dio;

  @override
  Future<Map<String, dynamic>> analyzeDream(
    String dreamContent,
    int dreamScore,
  ) async {
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

🪄 **꿈 해석 소제목**
- 꿈 해석에 대한 소제목을 10글자 이내로, 대화체로, 친근하게 만들어줘.
- 예: "금빛 용이 나오는 꿈이라...", "이런 꿈 꾼 적 있어?"

✨ **꿈의 해석**
꿈 속 각 요소들의 상징적 의미를 구체적으로 설명하고, 전체적인 해몽을 자세히 풀어서 알려줘.

🔧 **심리 해석 소제목**
- 심리 해석에 대한 소제목을 10글자 이내로, 대화체로, 친근하게 만들어줘.
- 예: "요즘 무언가 인정받고 싶어?", "마음이 답답했구나!"

🧠 **심리 상태 해석**
현재 마음 상태와 꿈과의 연관성을 자세히 분석해줘.

💡 **몽비의 조언**
따뜻하고 실용적인 조언 한마디!

🎈 **꿈 유형**
길몽, 일상몽, 악몽 중 한 가지 유형을 골라줘.

* 친근하고 재미있게 반말로 대화하듯 써줘
반드시 JSON만 출력해! 아무 설명이나 인삿말도 넣지마!
답변 형식 (JSON):
{
  "dreamKeywords": ["string", "string"],
  "psychologicalKeywords": ["string", "string"],
  "dreamSubTitle": "string",
  "dreamInterpretation": "string",
  "psychologicalSubTitle": "string",
  "psychologicalStateInterpretation": "string",
  "mongbiComment": "string",
  "dreamCategory": "string"
}
''';

      final requestBody = {
        'model': 'claude-sonnet-4-20250514',
        'max_tokens': 4024,
        'messages': [
          {'role': 'user', 'content': prompt},
        ],
      };

      final response = await dio.post('', data: requestBody);

      if (response.statusCode == 200) {
        var text = response.data['content'][0]['text'] as String;

        // 마크다운 코드 블록 제거 (```json ... ``` 또는 ``` ... ```)
        text = text.trim();
        if (text.startsWith('```json')) {
          text = text.substring(7).trim();
        } else if (text.startsWith('```')) {
          text = text.substring(3).trim();
        }
        if (text.endsWith('```')) {
          text = text.substring(0, text.length - 3).trim();
        }

        // 응답받은 꿈 해석 JSON String을 파싱해서 Map으로 변환
        final jsonResponse = jsonDecode(text) as Map<String, dynamic>;
        return jsonResponse;
      } else {
        final ex = Exception(
          'Claude API 호출 실패: ${response.statusCode} ${response.statusMessage}',
        );
        await Sentry.captureException(ex); // ✅ Sentry로 전송
        throw ex;
      }
    } on DioException catch (e, s) {
      final message = switch (e.response?.statusCode) {
        400 => 'API 요청 형식이 잘못되었습니다. 요청 데이터를 확인해주세요.',
        401 => 'API Key가 잘못되었습니다. 다시 확인해주세요.',
        404 => 'API 엔드포인트를 찾을 수 없습니다. URL 또는 모델명을 확인해주세요.',
        _ => '네트워크 오류: ${e.message}',
      };

      await Sentry.captureException(e, stackTrace: s);
      throw Exception(message);
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      throw Exception('알 수 없는 오류: $e');
    }
  }
}
