import 'package:flutter/foundation.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_naver_login/interface/types/naver_token.dart';
import 'package:mongbi_app/domain/entities/user.dart';
import 'package:mongbi_app/domain/use_cases/login_with_naver.dart';

class AuthViewModel extends ChangeNotifier {
  final LoginWithNaver _loginWithNaver;

  User? _user;
  User? get user => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  AuthViewModel(this._loginWithNaver);

  Future<void> loginWithNaver() async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _loginWithNaver.execute();
      _user = result;
      final NaverToken token = await FlutterNaverLogin.getCurrentAccessToken();
      print('✅ 로그인 성공: ${_user?.userName}');
      print('✅유저 accessToken: ${token.accessToken} ');
      print('✅유저 RefreshToken: ${token.refreshToken} ');
      print('✅유저 EpiresAt: ${token.expiresAt} ');
    } catch (e) {
      print('🧨 로그인 실패: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
