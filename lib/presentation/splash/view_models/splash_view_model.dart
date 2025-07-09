import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/domain/entities/user.dart';
import 'package:mongbi_app/domain/use_cases/get_user_info_use_case.dart';
import 'package:mongbi_app/presentation/remind/view_model/remind_time_setting_view_model.dart';
import 'package:mongbi_app/presentation/splash/view_models/splash_state.dart';
import 'package:mongbi_app/presentation/splash/view_models/splash_status.dart';
import 'package:mongbi_app/presentation/auth/viewmodels/auth_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashViewModel extends StateNotifier<SplashState> {

  SplashViewModel(this._getUserInfoUseCase, this.ref) : super(const SplashState());
  final GetUserInfoUseCase _getUserInfoUseCase;
  final Ref ref;

  Future<void> checkLoginAndFetchUserInfo() async {
    state = state.copyWith(status: SplashStatus.loading);

    try {
      final prefs = await SharedPreferences.getInstance();
      final isLogined = prefs.getBool('isLogined') ?? false;

      if (!isLogined) {
        state = state.copyWith(status: SplashStatus.needLogin);
        return;
      }

      final userList = await _getUserInfoUseCase.execute();
      ref.read(currentUserProvider.notifier).setUser(userList[0]);
      final reminderTime = await NotificationService().loadReminderTime();
      if (reminderTime != null) {
        state = state.copyWith(status: SplashStatus.successWithReminder, userList: userList);
      } else {
        state = state.copyWith(status: SplashStatus.successWithoutReminder, userList: userList);
      }
    } catch (_) {
      state = state.copyWith(status: SplashStatus.error);
    }
  }

  void setUser(User user) {
    state = state.copyWith(status: SplashStatus.success, userList: [user]);
  }

  void logout() {
    state = state.copyWith(status: SplashStatus.needLogin, userList: null);
  }
}
