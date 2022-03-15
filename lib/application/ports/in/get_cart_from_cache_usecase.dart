import 'package:shopping_cart/domain/cart.dart';

abstract class GetCartFromCacheUseCase {
  Future<Cart> getCart();
}