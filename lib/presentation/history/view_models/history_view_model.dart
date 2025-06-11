import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/domain/entities/history.dart';
import 'package:mongbi_app/providers/history_provider.dart';

class HistoryViewModel extends AutoDisposeAsyncNotifier<List<History>> {
  @override
  FutureOr<List<History>> build() async {
    return await fetchUserDreamsHistory();
  }

  Future<List<History>> fetchUserDreamsHistory() async {
    final fetchUserDreamsHistoryUseCase = ref.read(
      fetchUserDreamsHistoryUseCaseProvider,
    );

    state = const AsyncValue.loading();
    final history = await fetchUserDreamsHistoryUseCase.execute();
    state = await AsyncValue.guard(() async => history);
    return history;
  }

  List<History> searchDateTime(DateTime day) {
    final historyList = state.value ?? [];

    if (historyList.isNotEmpty) {
      for (final item in historyList) {
        final regDate = item.dreamRegDate;
        if (regDate.year == day.year &&
            regDate.month == day.month &&
            regDate.day == day.day) {
          return [item];
        }
      }
    }
    return [];
  }
}
