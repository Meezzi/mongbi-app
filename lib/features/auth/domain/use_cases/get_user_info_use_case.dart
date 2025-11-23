import 'package:mongbi_app/domain/repositories/user_info_repository.dart';
import 'package:mongbi_app/features/auth/domain/entities/user.dart';

class GetUserInfoUseCase {
  GetUserInfoUseCase(this.repository);
  final UserInfoRepository repository;

  Future<List<User>> execute() async {
    return await repository.getUserInfo();
  }
}
