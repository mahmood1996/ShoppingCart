import 'package:shopping_cart/domain/cart.dart';

abstract class GetCartAPIPort {
  Future<Cart>? getCart();
}