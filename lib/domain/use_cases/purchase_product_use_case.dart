import 'package:mongbi_app/domain/repositories/subscription_respository.dart';

class PurchaseProductUseCase {

  PurchaseProductUseCase(this.repository);
  final SubscriptionRepository repository;

  Future<void> call(String productId) {
    return repository.purchaseProduct(productId);
  }
}
