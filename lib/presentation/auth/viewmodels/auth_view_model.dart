import 'package:flutter/services.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_naver_login/interface/types/naver_login_result.dart';
import 'package:flutter_naver_login/interface/types/naver_login_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:mongbi_app/core/exceptions/auth_custom_exception.dart';
import 'package:mongbi_app/domain/entities/user.dart';
import 'package:mongbi_app/domain/use_cases/login_with_apple.dart';
import 'package:mongbi_app/domain/use_cases/login_with_kakao.dart';
import 'package:mongbi_app/domain/use_cases/login_with_naver.dart';
import 'package:mongbi_app/providers/account_provider.dart';
import 'package:mongbi_app/providers/auth_provider.dart';
import 'package:mongbi_app/providers/user_info_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthViewModel extends Notifier<User?> {
  late final LoginWithNaver _loginWithNaver;
  late final LoginWithKakao _loginWithKakao;
  late final LoginWithApple _loginWithApple;
  final _secureStorage = const FlutterSecureStorage();
  late final Future<SharedPreferences> _prefsFuture;
  @override
  User? build() {
    _loginWithNaver = ref.read(loginWithNaverUseCaseProvider);
    _loginWithKakao = ref.read(loginWithKakaoUseCaseProvider);
    _loginWithApple = ref.read(loginWithAppleUseCaseProvider);

    _prefsFuture = SharedPreferences.getInstance();
    return null;
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> loginWithApple() async {
    _isLoading = true;
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.fullName,
          AppleIDAuthorizationScopes.email,
        ],
      );
      final identityToken = credential.identityToken;

      if (identityToken != null) {
        final result = await _loginWithApple.execute(identityToken);
        state = result;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('lastLoginType', 'apple');
        await prefs.setBool('isLogined', true);
        ref.read(lastLoginTypeProvider.notifier).state = 'apple';

        final getUserUseCase = ref.read(getUserInfoUseCaseProvider);
        final userInfo = await getUserUseCase.execute();
        state = userInfo[0];
        return result.hasAgreedLatestTerms;
      } else {
        throw const AuthFailedException('Apple identity_token 없음');
      }
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) {
        throw const AuthCancelledException('로그인이 취소되었습니다.');
      }
      throw const AuthFailedException('로그인에 실패했습니다.');
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
    }
  }

  Future<bool> loginWithNaver() async {
    _isLoading = true;
    try {
      final loginResult = await FlutterNaverLogin.logIn();
      var accessToken = loginResult.accessToken?.accessToken;

      if (accessToken == null || accessToken.isEmpty) {
        final tokenResult = await FlutterNaverLogin.getCurrentAccessToken();
        accessToken = tokenResult.accessToken;
      }
      if (accessToken.isEmpty) {
        throw const AuthCancelledException('로그인이 취소되었습니다.');
      }

      final user = await _loginWithNaver.execute(accessToken);
      state = user;

      final prefs = await _prefsFuture;
      await prefs.setString('lastLoginType', 'naver');
      await prefs.setBool('isLogined', true);
      ref.read(lastLoginTypeProvider.notifier).state = 'naver';
      final getUserUseCase = ref.read(getUserInfoUseCaseProvider);
      final userInfo = await getUserUseCase.execute();
      state = userInfo[0];

      return user.hasAgreedLatestTerms;
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
    }
  }

  Future<bool> loginWithKakao() async {
    _isLoading = true;
    try {
      kakao.OAuthToken token;

      if (await kakao.isKakaoTalkInstalled()) {
        try {
          token = await kakao.UserApi.instance.loginWithKakaoTalk();
        } catch (error) {
          if (error is PlatformException && error.code == 'CANCELED') {
            throw const AuthCancelledException('로그인이 취소되었습니다.');
          }
          token = await kakao.UserApi.instance.loginWithKakaoAccount();
        }
      } else {
        token = await kakao.UserApi.instance.loginWithKakaoAccount();
      }

      final result = await _loginWithKakao.execute(token.accessToken);
      state = result;
      // await handleLoginResult(result.hasAgreedLatestTerms);
      final prefs = await _prefsFuture;
      await prefs.setString('lastLoginType', 'kakao');
      await prefs.setBool('isLogined', true);
      ref.read(lastLoginTypeProvider.notifier).state = 'kakao';
      final getUserUseCase = ref.read(getUserInfoUseCaseProvider);
      final userInfo = await getUserUseCase.execute();

      state = userInfo[0];
      return result.hasAgreedLatestTerms;
    } on PlatformException catch (e) {
      if (e.code == 'CANCELED') {
        throw const AuthCancelledException('로그인이 취소되었습니다.');
      }
      throw const AuthFailedException('로그인에 실패했습니다.');
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
    }
  }

  Future<void> updateUserInfo(User user) async {
    try {
      state = user;
    } catch (e) {}
  }

  Future<bool> logoutWithKakao() async {
    try {
      await kakao.UserApi.instance.unlink();
      final prefs = await _prefsFuture;
      await prefs.setBool('isLoginState', false);
      await prefs.setBool('isLogined', false);
      await _secureStorage.deleteAll();
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
        await prefs.setBool('isLogined', false);
        await _secureStorage.deleteAll();
        ref.read(splashViewModelProvider.notifier).logout();
        return true;
      }
      return false;
    } catch (error) {
      return false;
    }
  }

  Future<bool> logoutWithApple() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLogined', false);
      await prefs.setBool('isLoginState', false);
      await _secureStorage.deleteAll();
      ref.read(splashViewModelProvider.notifier).logout();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeAccount() async {
    final removeAccountUseCase = ref.read(removeAccountUseCaseProvider);
    return await removeAccountUseCase.execute();
  }
}

Future<bool> handleLoginResult(bool hasAgreedLatestTerms) async {
  return hasAgreedLatestTerms;
}
