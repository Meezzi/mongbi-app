import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/core/constants/deep_link.dart';
import 'package:mongbi_app/features/dream/domain/entity/dream.dart';
import 'package:mongbi_app/features/dream/presentation/models/dream_interpretation_state.dart';
import 'package:share_plus/share_plus.dart';

class DreamInterpretationViewModel extends Notifier<DreamInterpretationState> {
  @override
  DreamInterpretationState build() {
    return DreamInterpretationState();
  }

  void setDream(Dream dream) {
    state = DreamInterpretationState(
      dreamId: dream.id ?? 0,
      dreamSubTitle: dream.dreamSubTitle,
      dreamInterpretation: dream.dreamInterpretation,
      dreamKeywords: dream.dreamKeywords,
      psychologicalSubTitle: dream.psychologicalSubTitle,
      psychologicalStateInterpretation: dream.psychologicalStateInterpretation,
      psychologicalStateKeywords: dream.psychologicalStateKeywords,
      mongbiComment: dream.mongbiComment,
    );
  }

  void shareDreamInterpretation(String dreamSummary) {
    final message = '''
    🌙 [몽비] 오늘 꾼 꿈, 이런 의미래요!

    "$dreamSummary"

    👇 당신의 꿈도 해석해보세요!
    📱 몽비 앱 설치하기
    $branchShortLink
    ''';

    SharePlus.instance.share(ShareParams(text: message));
  }
}
