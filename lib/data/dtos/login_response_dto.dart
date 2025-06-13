import 'package:mongbi_app/data/dtos/user_dto.dart';

class LoginResponseDto {
  LoginResponseDto({required this.token, required this.user});
  final String token;
  final UserDto user;
}
