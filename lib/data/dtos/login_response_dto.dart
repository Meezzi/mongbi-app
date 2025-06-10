import 'package:mongbi_app/data/dtos/user_dto.dart';

class LoginResponseDto {
  final String token;
  final UserDto user;

  LoginResponseDto({
    required this.token,
    required this.user,
  });
}
