import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/data/data_sources/remote_user_info_data_source.dart';
import 'package:mongbi_app/data/dtos/user_dto.dart';
import 'package:mongbi_app/presentation/splash/view_models/splash_state.dart';
import 'package:mongbi_app/presentation/splash/view_models/splash_status.dart';
import 'package:mongbi_app/providers/user_info_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashViewModel extends StateNotifier<SplashState> {
  final RemoteUserInfoGetDataSource _dataSource;
  final Ref ref;

  SplashViewModel(this._dataSource, this.ref) : super(const SplashState());

  Future<void> checkLoginAndFetchUserInfo() async {
    state = state.copyWith(status: SplashStatus.loading);

    try {
      final prefs = await SharedPreferences.getInstance();
      final isLogined = prefs.getBool('isLogined') ?? false;

      if (!isLogined) {
        state = state.copyWith(status: SplashStatus.needLogin);
        return;
      }

      final userList = await _dataSource.fetchGetUserInfo();
      state = state.copyWith(status: SplashStatus.success, userList: userList);
      ref.read(currentUserProvider.notifier).setUser(userList[0].toEntity());
    } catch (_) {
      state = state.copyWith(status: SplashStatus.error);
    }
  }

  void setUser(UserDto user) {
    state = state.copyWith(status: SplashStatus.success, userList: [user]);
  }

  void logout() {
    state = state.copyWith(status: SplashStatus.needLogin, userList: null);
  }
}
