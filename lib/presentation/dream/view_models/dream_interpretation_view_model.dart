import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/domain/entities/dream.dart';
import 'package:mongbi_app/presentation/dream/models/dream_interpretation_state.dart';
import 'package:mongbi_app/providers/dream_provider.dart';

class DreamInterpretationViewModel extends Notifier<DreamInterpretationState> {
  @override
  DreamInterpretationState build() {
    return DreamInterpretationState();
  }

  void setDream(Dream dream) {
    state = DreamInterpretationState(
      dreamSubTitle: dream.dreamSubTitle,
      dreamInterpretation: dream.dreamInterpretation,
      dreamKeywords: dream.dreamKeywords,
      psychologicalSubTitle: dream.psychologicalSubTitle,
      psychologicalStateInterpretation: dream.psychologicalStateInterpretation,
      psychologicalStateKeywords: dream.psychologicalStateKeywords,
      mongbiComment: dream.mongbiComment,
    );
  }

  Future<bool> saveDream() async {
    final dreamWriteState = ref.read(dreamWriteViewModelProvider);
    final dreamEntity = Dream(
      createdAt: DateTime.now(),
      uid: 4, // TODO: 실제 로그인 사용자 ID로 교체
      challengeId: 0, // TODO: 실제 챌린지 ID로 교체
      content: dreamWriteState.dreamContent,
      score: dreamWriteState.selectedIndex,
      dreamKeywords: state.dreamKeywords,
      dreamSubTitle: state.dreamSubTitle,
      dreamInterpretation: state.dreamInterpretation,
      psychologicalSubTitle: state.psychologicalSubTitle,
      psychologicalStateInterpretation: state.psychologicalStateInterpretation,
      psychologicalStateKeywords: state.psychologicalStateKeywords,
      mongbiComment: state.mongbiComment,
      dreamCategory: state.dreamCategory,
    );

    return await ref.read(saveDreamUseCaseProvider).saveDream(dreamEntity);
  }
}
