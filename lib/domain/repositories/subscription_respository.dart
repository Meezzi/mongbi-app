import 'package:mongbi_app/domain/entities/subscriptionproduct.dart';

abstract class SubscriptionRepository {
  Future<List<SubscriptionProduct>> getAvailableProducts();
  Future<void> purchaseProduct(String productId);
}