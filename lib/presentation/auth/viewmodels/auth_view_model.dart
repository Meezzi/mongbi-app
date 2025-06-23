import 'package:flutter/services.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_naver_login/interface/types/naver_login_result.dart';
import 'package:flutter_naver_login/interface/types/naver_login_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:mongbi_app/data/data_sources/remote_user_info_data_source.dart';
import 'package:mongbi_app/domain/entities/user.dart';
import 'package:mongbi_app/domain/use_cases/login_with_kakao.dart';
import 'package:mongbi_app/domain/use_cases/login_with_naver.dart';
import 'package:mongbi_app/providers/auth_provider.dart';
import 'package:mongbi_app/providers/user_info_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends Notifier<User?> {
  late final LoginWithNaver _loginWithNaver;
  late final LoginWithKakao _loginWithKakao;
  late final Future<SharedPreferences> _prefsFuture;
  late final RemoteUserInfoGetDataSource _userInfoDataSource;

  @override
  User? build() {
    _loginWithNaver = ref.read(loginWithNaverUseCaseProvider);
    _loginWithKakao = ref.read(loginWithKakaoUseCaseProvider);
    _userInfoDataSource = ref.read(userInfoDataSourceProvider);
    _prefsFuture = SharedPreferences.getInstance();
    return null;
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loginWithNaver() async {
    _isLoading = true;
    try {
      final loginResult = await FlutterNaverLogin.logIn();
      var accessToken = loginResult.accessToken?.accessToken;

      if (accessToken == null || accessToken.isEmpty) {
        final tokenResult = await FlutterNaverLogin.getCurrentAccessToken();
        accessToken = tokenResult?.accessToken;
      }
      if (accessToken == null || accessToken.isEmpty) {
        throw Exception('네이버 accessToken 없음');
      }

      final user = await _loginWithNaver.execute(accessToken);
      state = user;

      final prefs = await _prefsFuture;
      await prefs.setString('lastLoginType', 'naver');
      await prefs.setBool('isLoginState', true);

      final getUserUseCase = ref.read(getUserInfoUseCaseProvider);
      final userInfo = await getUserUseCase.execute();
      state = userInfo[0];
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
    }
  }

  Future<void> loginWithKakao() async {
    _isLoading = true;
    try {
      kakao.OAuthToken token;

      if (await kakao.isKakaoTalkInstalled()) {
        try {
          token = await kakao.UserApi.instance.loginWithKakaoTalk();
        } catch (error) {
          if (error is PlatformException && error.code == 'CANCELED') {
            return;
          }
          token = await kakao.UserApi.instance.loginWithKakaoAccount();
        }
      } else {
        token = await kakao.UserApi.instance.loginWithKakaoAccount();
      }

      final result = await _loginWithKakao.execute(token.accessToken);
      state = result;

      final prefs = await _prefsFuture;
      await prefs.setString('lastLoginType', 'kakao');
      await prefs.setBool('isLoginState', true);

      final getUserUseCase = ref.read(getUserInfoUseCaseProvider);
      final userInfo = await getUserUseCase.execute();
      state = userInfo[0];
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
    }
  }

  Future<bool> logoutWithKakao() async {
    try {
      await kakao.UserApi.instance.unlink();
      final prefs = await _prefsFuture;
      await prefs.setBool('isLoginState', false);
      ref.read(splashViewModelProvider.notifier).logout();
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> logoutWithNaver() async {
    try {
      final NaverLoginResult res =
          await FlutterNaverLogin.logOutAndDeleteToken();
      if (res.status == NaverLoginStatus.loggedOut) {
        final prefs = await _prefsFuture;
        await prefs.setBool('isLoginState', false);
        ref.read(splashViewModelProvider.notifier).logout();
        return true;
      }
      return false;
    } catch (error) {
      return false;
    }
  }
}
