import 'package:mongbi_app/features/auth/domain/repositories/account_repository.dart';

class RemoveAccountUseCase {
  RemoveAccountUseCase(this.repository);

  AccountRepository repository;

  Future<bool> execute() async {
    return await repository.removeAccount();
  }
}
