import 'package:mongbi_app/data/dtos/user_dto.dart';

abstract interface class GetUserInfoDataSource {
  Future<UserDto> fetchGetUserInfo();
}
