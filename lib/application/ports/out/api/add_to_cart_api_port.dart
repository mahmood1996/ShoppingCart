import 'package:shopping_cart/domain/product.dart';

abstract class AddToCartAPIPort {
  Future<void> addToCart(Product product);
}