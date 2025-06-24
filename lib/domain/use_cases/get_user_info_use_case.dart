import 'package:mongbi_app/domain/entities/user.dart';
import 'package:mongbi_app/domain/repositories/user_info_repository.dart';

class GetUserInfoUseCase {
  GetUserInfoUseCase(this.repository);
  final UserInfoRepository repository;

  Future<List<User>> execute() async {
    return await repository.getUserInfo();
  }
}
