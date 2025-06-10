import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/presentation/dream/models/dream_write_state.dart';
import 'package:mongbi_app/providers/dream_provider.dart';

class DreamWriteViewModel extends Notifier<DreamWriteState> {
  @override
  DreamWriteState build() {
    return DreamWriteState();
  }

  void setDreamContent(String content) {
    state = state.copyWith(dreamContent: content);
  }

  void setSelectedIndex(int index) {
    state = state.copyWith(selectedIndex: index);
  }

  void setFocused(bool focused) {
    state = state.copyWith(isFocused: focused);
  }

  bool submitDream() {
    // 텍스트 필드 내용이 10글자 미만인 경우
    if (state.dreamContent.trim().length < 10) {
      return false;
    }
    // 감정이 선택되지 않은 경우
    if (state.selectedIndex == -1) {
      return false;
    }

    ref
        .read(analyzeDreamUseCaseProvider)
        .execute(state.dreamContent, state.selectedIndex);

    return true;
  }
}
