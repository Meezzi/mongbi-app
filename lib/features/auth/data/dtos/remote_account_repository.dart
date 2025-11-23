import 'package:mongbi_app/features/auth/data/data_sources/account_data_source.dart';
import 'package:mongbi_app/features/auth/domain/repositories/account_repository.dart';

class RemoteAccountRepository implements AccountRepository {
  RemoteAccountRepository(this.dataSource);

  AccountDataSource dataSource;

  @override
  Future<bool> removeAccount() async {
    return await dataSource.removeAccount();
  }
}
