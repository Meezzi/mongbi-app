import 'package:mongbi_app/data/dtos/login_response_dto.dart';

abstract interface class AuthDataSource {
  Future<LoginResponseDto> appleLogin(String identity_token);
}
