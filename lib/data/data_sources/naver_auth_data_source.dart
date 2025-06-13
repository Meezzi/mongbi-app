import 'package:mongbi_app/data/dtos/login_response_dto.dart';

abstract interface class AuthDataSource {
  Future<LoginResponseDto> naverLogin(String idToken);
}
