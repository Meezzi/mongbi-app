// splash_view_model.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/data/data_sources/remote_user_info_data_source.dart';
import 'package:mongbi_app/data/dtos/user_dto.dart';
import 'package:mongbi_app/presentation/splash/view_models/splash_status.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashViewModel extends StateNotifier<SplashStatus> {
  SplashViewModel(this._dataSource) : super(SplashStatus.initial);

  final RemoteUserInfoGetDataSource _dataSource;
  List<UserDto>? userList;

  Future<void> checkLoginAndFetchUserInfo() async {
    state = SplashStatus.loading;

    try {
      final prefs = await SharedPreferences.getInstance();
      final isLogined = prefs.getBool('isLogined') ?? false;

      if (!isLogined) {
        state = SplashStatus.needLogin;
        return;
      }

      userList = await _dataSource.fetchGetUserInfo(); // 내부에서 userIdx 꺼냄
      state = SplashStatus.success;
    } catch (_) {
      state = SplashStatus.error;
    }
  }
}
