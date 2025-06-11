import 'package:flutter/services.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_naver_login/interface/types/naver_token.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:mongbi_app/domain/entities/user.dart';
import 'package:mongbi_app/domain/use_cases/login_with_kakao.dart';
import 'package:mongbi_app/domain/use_cases/login_with_naver.dart';
import 'package:mongbi_app/providers/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> loginWithNaver() async {
    _isLoading = true;
    try {
      final result = await _loginWithNaver.execute();
      state = result;

      final prefs = await SharedPreferences.getInstance();
      String? value = prefs.getString('jwt_token');
      print(value);

      await prefs.setString('lastLoginType', 'naver');
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
    }
  }

  /// ✅ 카카오 로그인
  Future<void> loginWithKakao() async {
    _isLoading = true;
    try {
      kakao.OAuthToken token;

      if (await kakao.isKakaoTalkInstalled()) {
        try {
          token = await kakao.UserApi.instance.loginWithKakaoTalk();
          print('✅ 카카오톡으로 로그인 성공');
        } catch (error) {
          print('🧨 카카오톡으로 로그인 실패: $error');

          if (error is PlatformException && error.code == 'CANCELED') {
            return; // 사용자가 로그인 취소
          }

          // 카카오톡 실패 시 계정으로 시도
          token = await kakao.UserApi.instance.loginWithKakaoAccount();
          print('✅ 카카오계정으로 로그인 성공');
        }
      } else {
        token = await kakao.UserApi.instance.loginWithKakaoAccount();
        print('✅ 카카오계정으로 로그인 성공');
      }

      // 🔑 accessToken으로 서버 로그인
      final result = await _loginWithKakao.execute(token.accessToken);
      state = result;

      // ✅ SharedPreferences 저장
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token.accessToken); // (선택) 임시 저장
      await prefs.setString('lastLoginType', 'kakao');
    } catch (e) {
      print('🧨 최종 로그인 실패: $e');
      rethrow;
    } finally {
      _isLoading = false;
    }
  }
}
