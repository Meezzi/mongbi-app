import 'package:mongbi_app/domain/entities/subscriptionproduct.dart';
import 'package:mongbi_app/domain/repositories/subscription_respository.dart';

class GetAvailableProductsUseCase {

  GetAvailableProductsUseCase(this.repository);
  final SubscriptionRepository repository;

  Future<List<SubscriptionProduct>> call() {
    return repository.getAvailableProducts();
  }
}
