import 'package:mongbi_app/features/setting/data/dtos/user_dto.dart';

abstract interface class GetUserInfoDataSource {
  Future<List<UserDto>?> fetchGetUserInfo();
}
