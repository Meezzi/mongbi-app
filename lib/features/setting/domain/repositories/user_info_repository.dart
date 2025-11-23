import 'package:mongbi_app/features/auth/domain/entities/user.dart';

abstract interface class UserInfoRepository {
  Future<List<User>> getUserInfo();
}
