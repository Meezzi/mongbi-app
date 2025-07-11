import 'package:mongbi_app/data/data_sources/remote_inapp_purchase_data_source.dart';
import 'package:mongbi_app/domain/entities/subscriptionproduct.dart';
import 'package:mongbi_app/domain/repositories/subscription_respository.dart';

class SubscriptionRepositoryImpl implements SubscriptionRepository {

  SubscriptionRepositoryImpl(this.dataSource);
  final InAppPurchaseDataSource dataSource;

  @override
  Future<List<SubscriptionProduct>> getAvailableProducts() async {
    final products = await dataSource.fetchProducts([
      'premium_plan',
      'preminum_plan_year',
    ]);

    return products.map((p) => SubscriptionProduct(
      id: p.id,
      title: p.title,
      description: p.description,
      price: p.price,
    )).toList();
  }

  @override
  Future<void> purchaseProduct(String productId) async {
    final products = await dataSource.fetchProducts([productId]);
    final target = products.firstWhere((p) => p.id == productId);
    await dataSource.buy(productId, target);
  }
}
