import 'package:mongbi_app/domain/entities/challenge.dart';

class HomeState {
  const HomeState({
    this.challenge,
    this.isLoading = false,
    this.error,
    this.isCompleting = false,
  });

  final Challenge? challenge;
  final bool isLoading;
  final String? error;
  final bool isCompleting;

  HomeState copyWith({
    Challenge? challenge,
    bool? isLoading,
    String? error,
    bool? isCompleting,
  }) {
    return HomeState(
      challenge: challenge ?? this.challenge,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isCompleting: isCompleting ?? this.isCompleting,
    );
  }
}
