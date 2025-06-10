import 'package:google_sign_in/google_sign_in.dart';
import 'package:mongbi_app/domain/use_cases/login_with_google.dart';

class AuthViewModel {
  final GoogleLoginUseCase _useCase = GoogleLoginUseCase();

  Future<void> loginWithGoogle() async {
    final GoogleSignInAccount? account = await GoogleSignIn().signIn();
    if (account == null) throw Exception('사용자가 로그인을 취소했습니다.');

    final idToken = (await account.authentication).idToken;
    if (idToken == null) throw Exception('idToken 발급 실패');

    final user = await _useCase.execute(idToken);
    // user 저장하거나 상태 관리 적용
  }
}
