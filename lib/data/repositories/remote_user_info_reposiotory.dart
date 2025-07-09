import 'package:mongbi_app/data/data_sources/user_info_data_source.dart';
import 'package:mongbi_app/domain/entities/user.dart';
import 'package:mongbi_app/domain/repositories/user_info_repository.dart';

class RemoteUserInfoRepository implements UserInfoRepository {

  RemoteUserInfoRepository(this.dataSource);
  final GetUserInfoDataSource dataSource;

  @override
  Future<User> getUserInfo() async {
    final userDto = await dataSource.fetchGetUserInfo();
    return userDto.toEntity();
  }
}
