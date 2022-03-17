import 'package:shopping_cart/domain/cart.dart';

abstract class UpdateCartStatePort {
  Future<void>? updateCartState(Cart cart);
}