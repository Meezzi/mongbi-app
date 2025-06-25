import 'package:mongbi_app/data/data_sources/user_info_data_source.dart';
import 'package:mongbi_app/domain/entities/user.dart';
import 'package:mongbi_app/domain/repositories/user_info_repository.dart';

class RemoteUserInfoRepository implements UserInfoRepository {
  final GetUserInfoDataSource dataSource;

  RemoteUserInfoRepository(this.dataSource);

  @override
  Future<List<User>> getUserInfo() async {
    final userDtos = await dataSource.fetchGetUserInfo();
    if (userDtos == null) return [];

    // UserDto → User 변환
    return userDtos.map((dto) => dto.toEntity()).toList();
  }
}
