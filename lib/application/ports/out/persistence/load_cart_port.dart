import 'package:shopping_cart/domain/cart.dart';

abstract class LoadCartPort {
  Future<Cart> loadCart();
}