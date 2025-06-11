import 'package:mongbi_app/data/dtos/login_response_dto.dart';

abstract class AuthDataSource {
  Future<LoginResponseDto> KakaoLogin(String idToken);
}
