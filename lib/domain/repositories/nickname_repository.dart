import 'package:mongbi_app/data/data_sources/remote_nickname_setting_data_source.dart';
import 'package:mongbi_app/domain/entities/user.dart';

abstract interface class UserRepository {
  Future<User> updateNickname(int userId, String nickname);
}

class UserRepositoryImpl implements UserRepository {

  UserRepositoryImpl(this.remoteDataSource);
  final UserRemoteDataSource remoteDataSource;

  @override
  Future<User> updateNickname(int userId, String nickname) {
    return remoteDataSource.updateNickname(userId: userId, nickname: nickname);
  }
}
