import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongbi_app/data/data_sources/remote_inapp_purchase_data_source.dart';
import 'package:mongbi_app/data/repositories/remote_subscription_repository.dart';
import 'package:mongbi_app/domain/repositories/subscription_respository.dart';
import 'package:mongbi_app/domain/use_cases/fetch_available_productes_use_case.dart';
import 'package:mongbi_app/domain/use_cases/purchase_product_use_case.dart';
import 'package:mongbi_app/presentation/payment/view_models/subscription_view_model.dart';

final iapDataSourceProvider = Provider((ref) => InAppPurchaseDataSource());

final subscriptionRepositoryProvider = Provider<SubscriptionRepository>(
  (ref) => SubscriptionRepositoryImpl(ref.read(iapDataSourceProvider)),
);

final getProductsUseCaseProvider = Provider(
  (ref) => GetAvailableProductsUseCase(ref.read(subscriptionRepositoryProvider)),
);

final purchaseUseCaseProvider = Provider(
  (ref) => PurchaseProductUseCase(ref.read(subscriptionRepositoryProvider)),
);

final subscriptionViewModelProvider = ChangeNotifierProvider((ref) {
  return SubscriptionViewModel(
    getProducts: ref.read(getProductsUseCaseProvider),
    purchaseProduct: ref.read(purchaseUseCaseProvider),
  )..load();
});
