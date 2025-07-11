import 'package:flutter/foundation.dart';
import 'package:mongbi_app/domain/entities/subscriptionproduct.dart';
import 'package:mongbi_app/domain/use_cases/fetch_available_productes_use_case.dart';
import 'package:mongbi_app/domain/use_cases/purchase_product_use_case.dart';

class SubscriptionViewModel extends ChangeNotifier {
  SubscriptionViewModel({
    required this.getProducts,
    required this.purchaseProduct,
  });
  final GetAvailableProductsUseCase getProducts;
  final PurchaseProductUseCase purchaseProduct;

  List<SubscriptionProduct> products = [];
  int selectedIndex = 0;

  Future<void> load() async {
    products = await getProducts();
    notifyListeners();
  }

  void select(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  SubscriptionProduct get selectedProduct {
    if (selectedIndex == 0) {
      return products.firstWhere(
        (p) => p.id == 'preminum_plan_year',
        orElse: () => throw Exception('연간 구독 상품이 없습니다'),
      );
    } else {
      return products.firstWhere(
        (p) => p.id != 'preminum_plan_year',
        orElse: () => throw Exception('월간 구독 상품이 없습니다'),
      );
    }
  }

  Future<void> purchase() async {
    final selectedProduct = products[selectedIndex];
    await purchaseProduct(selectedProduct.id);
  }
}
