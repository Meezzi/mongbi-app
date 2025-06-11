import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_naver_login/interface/types/naver_token.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/domain/entities/user.dart';
import 'package:mongbi_app/domain/use_cases/login_with_naver.dart';
import 'package:mongbi_app/providers/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends Notifier<User?> {
  late final LoginWithNaver _loginWithNaver;

  @override
  User? build() {
    _loginWithNaver = ref.read(loginWithNaverUseCaseProvider);
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
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('lastLoginType', 'naver');
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
    }
  }

}
