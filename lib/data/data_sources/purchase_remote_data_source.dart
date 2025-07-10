import 'package:in_app_purchase/in_app_purchase.dart';

abstract interface class PurchaseDataSource {
  Future<List<ProductDetails>> fetchProducts(List<String> ids);
  Future<void> buy(String productId, ProductDetails product);
}
