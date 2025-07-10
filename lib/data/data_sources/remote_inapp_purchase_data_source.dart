import 'package:in_app_purchase/in_app_purchase.dart';

class InAppPurchaseDataSource {
  final InAppPurchase _iap = InAppPurchase.instance;

  Future<List<ProductDetails>> fetchProducts(List<String> ids) async {
    final response = await _iap.queryProductDetails(ids.toSet());
    return response.productDetails;
  }

  Future<void> buy(String productId, ProductDetails product) async {
    final param = PurchaseParam(productDetails: product);
    await _iap.buyNonConsumable(purchaseParam: param);
  }
}
