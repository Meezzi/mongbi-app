import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_naver_login/interface/types/naver_login_status.dart';
import 'package:mongbi_app/domain/entities/user.dart';

class NaverAuthDataSource {
  Future<User> login() async {
    final result = await FlutterNaverLogin.logIn();

    if (result.status != NaverLoginStatus.loggedIn || result.account == null) {
      throw Exception('네이버 로그인 실패');
    }

    final account = result.account!;

    return User(
      userIdx: 0,
      userName: account.name ?? 'Unknown', // null이면 기본값
      userNickname: null,
      userType: 'USER',
      userSocialType: 'NAVER',
      userSocialId: account.id ?? 'unknown_id',
      userSocialUuid: 'uuid-${account.id ?? 'unknown_id'}',
      userRegDate: DateTime.now(),
      userLastLoginDate: DateTime.now(),
      userIdState: 'ACTIVE',
    );
  }
}
