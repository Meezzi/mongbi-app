import 'package:mongbi_app/data/data_sources/account_data_source.dart';
import 'package:mongbi_app/domain/repositories/account_repository.dart';

class RemoteAccountRepository implements AccountRepository {
  RemoteAccountRepository(this.dataSource);

  AccountDataSource dataSource;

  @override
  Future<bool> removeAccount() async {
    return await dataSource.removeAccount();
  }
}
