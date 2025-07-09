import 'package:mongbi_app/domain/entities/user.dart';

abstract interface class UserInfoRepository {
  Future<User> getUserInfo();
}
