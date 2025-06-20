import 'package:flutter/services.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_naver_login/interface/types/naver_login_result.dart';
import 'package:flutter_naver_login/interface/types/naver_login_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:mongbi_app/domain/entities/user.dart';
import 'package:mongbi_app/domain/use_cases/login_with_kakao.dart';
import 'package:mongbi_app/domain/use_cases/login_with_naver.dart';
import 'package:mongbi_app/providers/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthViewModel extends Notifier<User?> {
  late final LoginWithNaver _loginWithNaver;
  late final LoginWithKakao _loginWithKakao;

  @override
  User? build() {
    _loginWithNaver = ref.read(loginWithNaverUseCaseProvider);
    _loginWithKakao = ref.read(loginWithKakaoUseCaseProvider);
    return null;
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loginWithApple() async {
    _isLoading = true;
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.fullName,
          AppleIDAuthorizationScopes.email,
        ],
      );
      print("애플 로그인 정보:$credential");
      final identityToken = credential.identityToken;

      print("애플 로그인 정보:$identityToken");

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('lastLoginType', 'apple');
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
    }
  }

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

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', accessToken);
      await prefs.setString('lastLoginType', 'naver');
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

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token.accessToken);
      await prefs.setString('lastLoginType', 'kakao');
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
    }
  }

  Future<bool> logoutWithKakao() async {
    try {
      await kakao.UserApi.instance.unlink();
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
        return true;
      }
      return false;
    } catch (error) {
      return false;
    }
  }
}
