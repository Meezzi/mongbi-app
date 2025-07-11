import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/core/secure_storage_service.dart';
import 'package:mongbi_app/presentation/dream/models/dream_write_state.dart';
import 'package:mongbi_app/providers/dream_provider.dart';

class DreamWriteViewModel extends AutoDisposeNotifier<DreamWriteState> {
  @override
  DreamWriteState build() {
    return DreamWriteState();
  }

  void setDreamContent(String content) {
    state = state.copyWith(dreamContent: content);
  }

  void setSelectedIndex(int index) {
    state = state.copyWith(selectedIndex: index);
    ref.read(selectedDreamScoreProvider.notifier).state = index + 1;
  }

  void setFocused(bool focused) {
    state = state.copyWith(isFocused: focused);
  }

  Future<void> submitDream({bool isReInterpretation = false}) async {
    if (state.dreamContent.trim().length < 10) return;
    if (state.selectedIndex == -1) return;
    final uid = await SecureStorageService().getUserIdx();
    if (uid == null) return;

    final dream = await ref
        .read(analyzeAndSaveDreamUseCaseProvider)
        .execute(uid, state.dreamContent, state.selectedIndex + 1);

    ref.read(dreamInterpretationViewModelProvider.notifier).setDream(dream);
  }
}
