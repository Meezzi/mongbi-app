import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/domain/entities/dream.dart';
import 'package:mongbi_app/presentation/dream/models/dream_interpretation_state.dart';

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
}
