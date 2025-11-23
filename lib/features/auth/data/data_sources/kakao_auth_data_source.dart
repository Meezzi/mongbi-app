import 'package:mongbi_app/features/auth/data/dtos/login_response_dto.dart';

abstract interface class AuthDataSource {
  Future<LoginResponseDto> kakaoLogin(String idToken);
}
