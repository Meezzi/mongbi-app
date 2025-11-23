class DreamWriteState {
  DreamWriteState({
    this.dreamContent = '',
    this.selectedIndex = -1,
    this.isFocused = false,
  });

  final String dreamContent;
  final int selectedIndex;
  final bool isFocused;

  DreamWriteState copyWith({
    String? dreamContent,
    int? selectedIndex,
    bool? isFocused,
  }) {
    return DreamWriteState(
      dreamContent: dreamContent ?? this.dreamContent,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isFocused: isFocused ?? this.isFocused,
    );
  }
}
